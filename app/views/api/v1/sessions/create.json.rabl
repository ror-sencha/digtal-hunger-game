object @user
extends("api/v1/users/base")
glue(@auth_token) do
  attributes :auth_token
end