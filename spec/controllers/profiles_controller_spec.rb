require 'rails_helper'

describe ProfilesController do


	# TODO: 
	context 'unauthenticated user' do

	end

	context 'logged in user' do
		
		# Remember, the profile association is the only
		# one that we set up in our factory.
		let(:user){ create(:user) }

	  before :each do
	    request.cookies["auth_token"] = user.auth_token
	  end


	  describe 'GET #show' do
	  	

	  	it 'sets the profile as @profile' do
	  		get :show, :id => user.profile.id
		  	expect(assigns(:profile)).to eq(user.profile)
	  	end


	  	it 'sets the user as @user' do
	  		get :show, :id => user.profile.id
	  		expect(assigns(:user)).to eq(user)
	  	end

	  end


	  describe 'PATCH #update' do
	  	

	  	context 'with valid attributes' do
	  		
	  		let(:updated_college){"Updated University"}

	  		
	  		it 'finds the proper profile' do
	  			put :update, :id => user.profile.id, :profile => attributes_for(:profile, :college => updated_college)
	  			expect(assigns(:profile)).to eq(user.profile)	
	  		end

	  		
	  		it 'redirects to the profile_path upon update' do
	  			put :update, :id => user.profile.id, :profile => attributes_for(:profile, :college => updated_college)
	  			expect(response).to redirect_to profile_path
	  		end


	  		it 'actually updates the user' do
	  			put :update, :id => user.profile.id, :profile => attributes_for(:profile, :college => updated_college)
	  			user.reload
	  			expect(user.profile.college).to eq(updated_college)
	  		end


	  		it 'sets the flash properly after update' do
	  			put :update, :id => user.profile.id, :profile => attributes_for(:profile, :college => updated_college)
	  			expect(flash["success"]).to eq("Profile updated!")
	  		end

	  	end # /context with valid attributes


	  end


	end


end