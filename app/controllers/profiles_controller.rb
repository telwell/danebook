class ProfilesController < ApplicationController

	def show
		@profile = Profile.find(params[:id])
		@user = @profile.user
	end

	
	def edit
		@profile = Profile.find(params[:id])
		@user = @profile.user
	end


	def update
		@profile = Profile.find(params[:id])
		if @profile.update(profile_params)
			flash[:success] = "Profile updated!"
			redirect_to profile_path
		else
			flash.now[:error] = "Sorry, your profile could not be saved."
			render :edit
		end
	end

private
	
	
	def profile_params
		params.require(:profile).
					permit(:college, 
									:hometown, 
									:currently_live, 
									:phone, 
									:words_to_live_by,
									:bio
								)
	end


end
