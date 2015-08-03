class SessionsController < ApplicationController


	def create
		@user = User.find_by_email(params[:email])
		if @user && @user.authenticate(params[:password])
			sign_in(@user)
			flash[:success] = "Successfully logged in!"
			redirect_to root_url
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
