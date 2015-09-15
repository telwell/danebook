class FriendshipsController < ApplicationController
	
	def create
		@profile = Profile.find(params[:profile_id])
		@friendship = current_user.friendships.build(:friend_id => @profile.user.id)
		if @friendship.save
			flash[:success] = "Friend Added!"
			redirect_to profile_path(@profile)
		else
			flash[:notice] = "Error Adding Friend"
			redirect_to profile_path(@profile)
		end
	end

	def destroy
		@friendship = current_user.friendships.find(params[:id])
		@friendship.destroy
	  flash[:notice] = "Friendship Removed."
	  redirect_to profile_path(params[:profile_id])
	end

end
