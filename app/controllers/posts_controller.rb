class PostsController < ApplicationController
	# This filter will set the controller name in our session
	# so that we can use it elsewhere. Specifically to be used
	# in our polymorphic comments relationship. We need to ensure
	# that we include this filter on other places where there is 
	# polymorphism as well, specifically photos. Used in comments_controller 
	
	# TODO: Change the routes to not get the polymorphic_type from the session, 
	# rather, it makes more sense to do this through the routes like in the 
	# reading on polymorphism.
	before_filter :set_referrer_controller

	def show
		@profile = Profile.find(params[:profile_id])
		@user = @profile.user
		@friends = @user.friends
		@post = Post.new
		@comment = Comment.new
	end

	def create
		@post = @current_user.posts.build(post_params)

		if @post.save
			flash[:success] = "Post created successfully!"
			redirect_to profile_posts_path(@current_user.profile)
		else
			flash[:error] = "Error creating post"
			render :show
		end
	end

	def destroy
		@post = Post.find(params[:profile_id])
		if @post.destroy
			flash[:success] = "Post deleted successfully!"
			redirect_to profile_posts_path(@post.profile)
		else
			flash[:error] = "Post unable to be deleted"
			render :show
		end
		
	end


private
	
	def post_params
		params.require(:post).permit(:content)
	end

end
