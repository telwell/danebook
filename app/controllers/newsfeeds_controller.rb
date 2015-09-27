class NewsfeedsController < ApplicationController
	

	def show
		@profile = Profile.find(params[:profile_id])
		@user = @profile.user
		@friends = @user.friends
		@post = Post.new
		@comment = Comment.new
		@friends_posts = get_newsfeed_posts
		
		# We don't want users to be able to view other user's newsfeeds
		# so this before filter will redirect them to their own newsfeed
		redirect_to profile_newsfeed_path(current_user.profile) unless belongs_to_current_profile_user?
	end



private
	def get_newsfeed_posts
		friend_ids = @friends.pluck(:id)
		# I did it this way because we want to return an 
		# ActiveRecord relation not just an array.
		Post.where(:author_id => friend_ids)
	end

end
