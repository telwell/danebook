class PhotosController < ApplicationController

	def index
		@profile = Profile.find(params[:profile_id])
		@user = @profile.user
		@photos = @user.photos
	end

	def new
		@profile = Profile.find(params[:profile_id])
		@user = @profile.user
		@photo = Photo.new
	end

	def create
		@photo = Photo.new(photo_params)
		@photo.user_id = current_user.id
    if @photo.save
      flash[:success] = "Photo added!"
      redirect_to profile_photos_path(params[:profile_id])
    else
      flash.now[:error] = "Failed to Add Photo!"
      render :new
    end
	end

private
	
	def photo_params
		params.require(:photo).permit(:photo, :user_id, :title, :description)
	end

end
