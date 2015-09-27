module NewsfeedsHelper

	# Will return true if the user has posted a post within
	# the last 2 weeks.
	def recently_active?(user)
		user.posts.pluck(:created_at).any? { |d| d > 2.weeks.ago }
	end

end