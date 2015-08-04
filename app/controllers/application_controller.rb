class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # We don't just want to access @current_user
  # in one particular controller, so best to set it
  # for all of our controllers.
	before_filter :current_user

private

	# Store our ID in the session and set the 
	# current_user instance variable.
	def sign_in(user)
		user.regenerate_auth_token
		cookies.permanent[:auth_token] = user.auth_token
		@current_user = user
	end


	def sign_out
		@current_user = nil
		cookies.delete(:auth_token)
	end


	# If our session is set then set our @current_user
	# Otherwise query the db using the session
	def current_user
		@current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]		
	end
	helper_method :current_user


	# Just turn @current_user into a boolean
	def signed_in_user?
		!!current_user
	end
	helper_method :signed_in_user?

	def belongs_to_current_user?
		@current_user.profile.id.to_s == params[:id] ? true : false
	end
	helper_method :belongs_to_current_user?


end
