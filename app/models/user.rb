class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  include ApiErrors
  
  devise :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, :email, :status, presence: true
 
  USER_STATUS = %w(spectator md player judge admin)

  has_attached_file :avatar,
                    :styles => { :thumb => "50x50>", :medium => "200x200>", :large => "640x640>"},
                    :path => "public/system/user_logo/:attachment/:id_partition/:style/:filename",
                    :url => "/system/user_logo/:attachment/:id_partition/:style/:filename"

  #has_attached_file :avatar,
  #  :styles => { :thumb => "50x50>", :medium => "200x200>", :large => "640x640>"},
  #  :storage => :s3,
  #  :s3_credentials => "#{Rails.root}/config/amazon_s3.yml",
  #  :path => "/user-logo/:id/:style/:filename"

  ## Relationship
  has_many :authentication_tokens, :dependent => :destroy
  has_many :challenges, :dependent => :destroy
  has_many :mini_challenges, :dependent => :destroy
  has_many :recent_activities
  has_many :challenge_likes
  has_many :user_skills
  has_many :user_endorses
  has_many :activity_feeds, :dependent => :destroy
  has_many :feed_comments
  has_many :mini_challenge_answers
  has_many :social_media_points
  has_many :judge_points
  has_many :player_challenges
  has_many :minichallenge_points
  has_many :challenges_points
  has_many :support_points
  has_many :login_points
  accepts_nested_attributes_for :user_skills
  ## Scopes

  scope :with_email, lambda { |email| where("email = ?", email) }
  scope :list_spectator, where("status = ?", "spectator")
  scope :list_judge,     where("status = ?", "judge")
  scope :list_md,        where("status = ?", "md")
  scope :list_player,    where("status = ?", "player")
  scope :list_user_without_admin, where("status != ?", "admin")
  scope :search, lambda {|name| where("name LIKE ?", "%#{name}%")}

  class << self
    def authenticate(email, password)
      return nil, "Email and Password is required" if email.blank? && password.blank?
      return nil, "Email is required" if email.blank?
      return nil, "Password is required" if password.blank?
      user = with_email(email).try(:first)
      if user
        if user.valid_password?(password)
          return user, ''
        else
          return nil, 'Password is invalid'
        end
      else
        return nil, "User not found with '#{email}' email"
      end
    end
  end

  def search_by_name(name)
    where("name LIKE ?", "%#{name}%")
  end

  def is_admin?
    self.status.downcase == "admin"
  end

  def create_token
    self.authentication_tokens.create_new_token
  end

  def avatar_url
    if self.avatar_file_name.present?
      "#{DOMAIN_CONFIG}/#{self.avatar.url}"
    else
      "#{DOMAIN_CONFIG}/assets/male.png"
    end
  end

  def fullname
    "#{self.name} #{self.last_name}"
  end

  def mdid
    self.id
  end

  def is_player?
    self.status == "player"
  end


  def decode_image_data(img_data)
    cid           =   URI.unescape(img_data)
    filename      =   "avatar_#{Time.now.to_i}"
    file          =   File.open("#{Rails.root.to_s}/public/tmp/#{filename}.png","wb")
    temp2         =   Base64.decode64(cid)
    file.write(temp2)
    file.close
    f                =   File.open("#{Rails.root.to_s}/public/tmp/#{filename}.png")
    self.avatar   =   f
    f.close
    File.delete("#{Rails.root.to_s}/public/tmp/#{filename}.png")
  end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      user = find_by_email(row["Email"])
      unless user.present?
        user = User.new
        user.name = row["Name"]
        user.last_name = row["LastName"]
        user.email = row["Email"]
        if row["judge"].downcase.to_s == "true"
          user.status = "judge"
        elsif row["md"].downcase.to_s == "true"
          user.status = "player"
        elsif row["spectator"].downcase.to_s == "true"
          user.status = "spectator"
        end
        user.password = "aaxbbxccx11x22x33" #row["password"]
        user.password_confirmation = "aaxbbxccx11x22x33" #row["password"]
        user.save
        test = HungerMailer.invitation_for_signup(user.email, user.name).deliver if user.save
        user
      end
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      find(:all)
    end
end
end
