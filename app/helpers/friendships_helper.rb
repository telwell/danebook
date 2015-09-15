module FriendshipsHelper
	
	# This helper will return true if the profile of the current user
	# has been friended by the current user. False otherwise.
	def friend_of_current_user?
		current_user.friends.pluck(:id).include?(@profile.user.id) ? 
			current_user.friendships.find_by_friend_id(@profile.user.id) : false
	end
end
