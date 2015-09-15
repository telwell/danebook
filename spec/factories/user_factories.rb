# A User, by default, has a profile 
#created with it via the users controller

FactoryGirl.define do

	factory :user do
		first_name  						"Foo"
		last_name   						"Bar"
		# Sequence here!
		sequence(:email){ |n| "foo#{n}@bar.com"}       			
		password								"password"
		password_confirmation 	"password"
		birthday 								"1980-01-01"
		gender									1

		after(:create) do |user|
			create(:profile, :user_id => user.id)
		end

		factory :user_with_post_like do
			after(:create) do |user|
				post = create( :post, :author_id => user.id )
				create( :like, :user_id => user.id, :likeable_id => post.id )
			end
		end

		factory :user_with_friend do
			after(:create) do |user|
				another_user = create(:user)
				friend = create(:friendship, :user_id => user.id, :friend_id => another_user.id )
			end
		end

	end
	
end