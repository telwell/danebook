class Friendship < ActiveRecord::Base
	# Join associations
	belongs_to :user
	belongs_to :friend, :class_name => "User"

end
