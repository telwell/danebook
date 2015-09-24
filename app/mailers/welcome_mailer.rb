class WelcomeMailer < ApplicationMailer
	default :from => "me@trevorelwell.com"

	def welcome(user)
		@user = user
		mail(to: @user.email, subject: 'Welcome to TrevBook!')
	end

end