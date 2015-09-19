class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :must_be_signed_in

  # We don't just want to access @current_user
  # in one particular controller, so best to set it
  # for all of our controllers.
	before_filter :current_user

	# I delegated some methods to the ApplicationHelper
	# in order to do view testing.
	include ApplicationHelper

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

	
	def must_be_signed_in
		unless signed_in_user?
			flash[:error] = "Must be signed in to view this page!"
			redirect_to root_url
		end	
	end


	def set_referrer_controller
		session[:referrer_controller] = controller_name
	end

	def commentable_type_from_referrer
		path_array = URI.parse(request.referrer).path.split("/")
		if path_array.include?("photos")
			"Photo"
		elsif path_array.include?("posts")
			"Post"
		end
	end


	def commentable_id_from_referrer
		if params[:referrer_id]
			# This means that we're coming from a Post which 
			# doesn't have the post.id in the path
			params[:referrer_id]
		else
			path_array = URI.parse(request.referrer).path.split("/")
			# We want to return the last item in this array since they're nested
			path_array[-1]
		end
	end

end