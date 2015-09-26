class Comment < ActiveRecord::Base
	
	# Let's add our associations
		belongs_to :commentable, :polymorphic => true
		belongs_to :author, :class_name => "User"
		belongs_to :profile 
		
	# End associations
		after_create :send_new_comment_email
	# Filters
		

	# Including concerns for likeable model
	include Likeable


private
	

	# QUESTION: Is using .deliver_later here enough to actually handle
	# this delivery async? 
	def send_new_comment_email
		TriggerMailer.new_comment(self).deliver_later
	end


end