class SessionsController < ApplicationController

	skip_before_filter :must_be_signed_in, :only => [:create]

	def create
		@user = User.find_by_email(params[:email])
		if @user && @user.authenticate(params[:password])
			sign_in(@user)
			flash[:success] = "Successfully logged in!"
			# TODO: This doesn't seem to be working on Heroku... verify
			# that it's working locally too please?
			redirect_to profile_newsfeed_path(@user.profile)
			
		else
			flash.now[:error] = "Couldn't log you in, please try again."
			error_model = @user
			render '/users/new'
		end
	end


	def destroy
		flash[:success] = "You've been signed out."
		sign_out
		redirect_to root_url
	end


end
