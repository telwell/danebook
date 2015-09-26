class SearchesController < ApplicationController

	
	def show
		@query = params[:query]
		@profile = Profile.find(params[:profile_id])
		@user = @profile.user
		@found_users = User.search(@query)
	end


end