namespace :hunger_game do
  
  desc "Add Email Template"
  task :add_default_email_template => :environment do
    templates =  ["Registration Email Template", "New Challenge Template", "Player Denied Email Template", "Player Winner Email Template" ]

    puts("=========P L E A S E   W A I T ... ==========")
    templates.each do |t|
      EmailTemplate.find_or_create_by_name(:name => t, :content => "Please write your content here....")
    end
  end

  desc "Add Email Blast"
  task :add_default_email_blast => :environment do
    puts("=========P L E A S E   W A I T ... ==========")
    EmailBlast.find_or_create_by_title(:title => "Blast Email", :content => "Please write your content here....")
  end


  desc "Add Skills"
  task :add_skills => :environment do
    puts("=========P L E A S E   W A I T ... ==========")
    Skill.delete_all
    SKILLS = ["Endorse Social Media", "Entrepreneurship", "Business Development", "Talent Acquisition", "Customer Service", "Negotiation", "Data Analysis", "Financial Analysis", "Digital Strategy", "HTML/CSS", "Brand Management", "Sales", "Change Management", "Networking", "Fundraising", "Account Management", "Team Building", "Product Design", "Project Management", "Information Architecture", "Public Speaking", "Lead Generation", "Thought Leadership", "Negotiations", "Mergers & Acquisitions", "Competitive Analysis", "HTML5", "Ruby on Rails"]
    SKILLS.each do |skill|
      Skill.create(:name => skill)
    end
  end
end