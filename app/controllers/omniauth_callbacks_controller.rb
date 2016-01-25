class OmniauthCallbacksController < Devise::OmniauthCallbacksController 
	#controls requests from fb app
	def facebook
		#get user variable from users.rb database
		@user = User.from_omniauth(request.env["omniauth.auth"])

		#if we can find user, we can say, successfully signed in or redirect to sign up page
		if @user.persisted?
			sign_in_and_redirect @user, :event => :authentication
			set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
		else
			session["devise.facebook_data"] = request.env["omniauth.auth"]
			redirect_to new_user_registration_url
		end
	end

end