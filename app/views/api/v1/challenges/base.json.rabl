object @challenge
attributes :id, :title, :start_date, :end_date, :description, :is_published, :created_at
node :challenge_id do |c|
	c.id
end

node :posted do |c|
	c.pchallenge(@user, c.id)
end

child :document_challenge => "document_challenge" do |d|
  attribute :document_challenge_avatar
end
child :video_challenge => "video_challenge" do |d|
  attribute :video_challenge_avatar
end
