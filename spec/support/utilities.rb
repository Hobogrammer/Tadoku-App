include ApplicationHelper

def sign_in
  mock_auth_hash
  visit signin_path
end
