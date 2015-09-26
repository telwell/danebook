# There's really not much here, just 
# the bare bones like.

FactoryGirl.define do

	factory :comment do
		commentable_type			"Post"
		content 							"Look, a comment!"
	end

	factory :photo_comment do
		commentable_type 			"Photo"
		content								"Your photo is great!"
	end
	
end