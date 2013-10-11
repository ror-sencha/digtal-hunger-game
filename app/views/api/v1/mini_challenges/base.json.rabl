object @mini_challenge
attributes :id, :title, :question, :user_id
child :challenge_options, :object_root => false do
  extends("api/v1/mini_challenges/option")
end
