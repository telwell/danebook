class CommentsController < ApplicationController

	before_filter :set_comment_params, :only => [:create]

	def create
		@comment.content = params[:comment][:content]
		if @comment.save
			flash[:success] = 'Thanks for your comment!'
			redirect_to request.referrer
		else
			flash[:error] = "Sorry, your commentn didn't go through!"
			reciredt_to request.referrer
		end
	end


	def destroy
		@comment = Comment.find(params[:id])
		if @comment.delete
			flash[:success] = "Your embarrassing comment was deleted!"
			redirect_to request.referrer
		else
			flash[:error] = "Your comment was not deleted!"
			# QUESTION: Can you do this? Seems faulty. ANSWSER: NO! Must redirect_to
			redirect_to request.referrer
		end
	end

private

	
	def comment_params
		params.require(:comment).permit(:content, :commentable_type, :commentable_id, :author_id)
	end

	# TODO!!: Make this go downstream from comment params...
	# def full_comment_params

	# 	my_hash[:commentable_id]
	# 	}
	# end

	# Need to set the other params for the comment via params and session
	# QUESTION: THIS ALL SEEMS SMELLY, WHAT'S A BETTER WAY TO SET THESE?!
	def set_comment_params
		# I'm going to get these from the request.referrer, this way it's a 
		# bit harder to actually spoof.
		# NOTE: Had to include .to_i for commentable_id otherwise it wasn't saving properly.
		@comment = Comment.new
		@comment.commentable_type = commentable_type_from_referrer
		@comment.commentable_id = commentable_id_from_referrer.to_i
		@comment.author_id = @current_user.id
	end

end
