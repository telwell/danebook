require 'rails_helper'

describe UsersController do
	

	# All the SHOULDA's
	it { should use_before_action(:must_be_signed_in) }


	context "unauthenticated user" do
			

		let(:user){ create(:user) }


		describe 'GET #new' do
			

			it '@user creates an object of type User' do
				get :new
				expect(assigns(:user)).to be_a(User)
			end


			it 'instantiates a blank User' do
				get :new
				expect(assigns(:user)).to_not be_persisted
			end


			it 'renders the proper template' do
				get :new
				expect(response).to render_template :new
			end

		end


		describe 'POST #create' do


			it 'creates a User' do
				expect{ post :create, :user => attributes_for(:user) }.to change(User, :count).by(1)
			end


			it 'redirects to user profile path after creation' do
				post :create, :user => attributes_for(:user)
				expect(response).to redirect_to profile_path(assigns(:user).id)
			end


			it 'sets the flash after a user is created' do
				post :create, :user => attributes_for(:user)
				expect(flash[:success]).to eq("User created successfully!")
			end

		end


	end

end