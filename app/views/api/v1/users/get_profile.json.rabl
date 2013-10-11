object @user
extends("api/v1/users/base")
child :recent_activities, :object_root => false do
	extends("api/v1/users/recent_activity")
end
