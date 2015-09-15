class PhotosController < ApplicationController

	before_filter :photo_from_url, :only => [:create]

	def index
		@profile = Profile.find(params[:profile_id])
		@user = @profile.user
		@photos = @user.photos
	end

	def show
		@profile = Profile.find(params[:profile_id])
		@user = @profile.user
		@photo = Photo.find(params[:id])
		@comment = Comment.new
	end

	def new
		@profile = Profile.find(params[:profile_id])
		@user = @profile.user
		@photo = Photo.new
	end

	def create
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

	def photo_from_url
		if params[:photo_url].present?
			@photo = Photo.new
			@photo.photo_from_url(params[:photo_url])
		else
			@photo = Photo.new(photo_params)
		end
	end

end
