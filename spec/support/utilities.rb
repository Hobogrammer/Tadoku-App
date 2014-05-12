include ApplicationHelper

def sign_in(user)
  mock_auth_hash
  visit signin_path
end
