require 'rails_helper'

feature 'Friendship functionality' do

	let(:another_user){ create(:user) }

	context "user with no friends" do

		let(:user){ create(:user) }

		before do
			sign_in(user)
			visit profile_path(another_user)
		end

		scenario "sees Add Friend button on another user's profile page" do			
			expect(page).to have_content "Add Friend"
		end

		scenario "clicking Add Friend button increases friend count" do
			friendship = Friendship.find_by_user_id(user.id)
			expect{ click_on('Add Friend') }.to change(Friendship, :count).by(1)
		end

	end

	context "user with a friend" do
		
		let(:user){ create(:user_with_friend) }

		scenario "sees Remove Friend button on another user's profile page" do
			sign_in(user)
			friendship = Friendship.find_by_user_id(user.id)
			visit profile_path(friendship.friend_id)
			expect(page).to have_content "Remove Friend"
		end

		scenario "clicking Remove Friend button decreases friend count" do
			sign_in(user)
			friendship = Friendship.find_by_user_id(user.id)
			visit profile_path(friendship.friend_id)
			expect{ click_on('Remove Friend') }.to change(Friendship, :count).by(-1)
		end

	end

end