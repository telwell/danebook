require 'rails_helper'

describe "posts/show.html.erb" do

	context 'with a signed in user' do
		
		let(:user){ create(:user) }
		let(:post){ create(:post, :author_id => user.id) }
		# Need this comment in order to re-render the page
		# with the form_for for comments.
		let(:comment){ create(:comment, :author_id => user.id, :commentable_id => post.id) }

		before do
			

			# Setting our instance variables each time.
			assign(:user, user)
			assign(:current_user, user)
			assign(:profile, user.profile)
			assign(:post, post)
			assign(:comment, comment)


			# DUP 1
			def view.signed_in_user?
				true
			end


			@user = user
			def view.current_user
				@user
			end


			def view.controller_name
				"posts"
			end
		end


		it 'does NOT show link to edit profile' do
			render
			expect(rendered).not_to match("<a .*>Edit Profile</a>")
		end

	end

end