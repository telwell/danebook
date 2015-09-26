class TriggerMailer < ApplicationMailer
	

	default :from => "me@trevorelwell.com"

	
	def new_comment(comment)
		@user = comment.commentable.profile.user
		@comment = comment
		mail(to: @user.email, subject: "Someone commented on your #{@comment.commentable_type.downcase}!")
	end


end
