require 'rails_helper'

describe "users/new.html.erb" do

	context 'with a signed in user' do
		
		let(:user){ create(:user) }

		before do
			def view.signed_in_user?
				true
			end

			@user = user
			def view.current_user
				@user
			end

		end


		# QUESTION: Something interesting I found here is that
		# though my form_for's would normally work in development/production
		# when I went to test I would get errors b/c I didn't specify the 
		# :url and/or :method. I thought that was very interesting.
		it 'shows the users name' do
			assign(:user, user)
			assign(:current_user, user)
			assign(:profile, user.profile)
			allow(view).to receive(:params).and_return({profile_id: user.profile.id})
			render
			expect(rendered).to match(user.first_name)
		end

	end

end