include ApplicationHelper

def sign_in(user)
	OmniAuth.config.test_mode = true
	visit signin_path
end
