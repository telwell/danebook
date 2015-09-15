require 'rails_helper'

describe User do
    # Using the Shoulda gem, it forces you to test
    # associations like this:
    it { should have_one(:profile) }
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:friends) }
    it { should have_many(:friendships) }
    it { should have_many(:inverse_friends) }
    it { should have_many(:inverse_friendships) }
    it { should have_many(:photos) }
    it { should have_secure_password }

	let(:user){ build(:user) }

	context 'validations' do

		it 'is valid with the default attributes' do
            expect(user).to be_valid
		end

		it "saves with default attributes" do
          expect{ user.save! }.to_not raise_error
        end

        # must have an email
        it 'throws error without an email' do
        	user = build(:user, :email => nil)
        	expect{ user.save! }.to raise_error(ActiveRecord::RecordInvalid)
        end

        # must have a last name
        it 'throws error without a last name' do
        	user = build(:user, :last_name => nil)
        	expect{ user.save! }.to raise_error(ActiveRecord::RecordInvalid)
        end

        # password must be between 8..24 characters
        it 'will fail with a password < 8 characters' do
            user = build(:user, :password => 'aa', :password_confirmation => 'aa')
            expect{ user.save! }.to raise_error(ActiveRecord::RecordInvalid)
        end

        it 'will fail with a password > 24 characters' do
            user = build(:user, :password => 'aa'*30, :password_confirmation => 'aa'*30)
            expect{ user.save! }.to raise_error(ActiveRecord::RecordInvalid)
        end

        it 'doesnt accept a gender identifier other than 1 or 2' do
            user = build(:user, :gender => 3)
            expect{ user.save! }.to raise_error(ActiveRecord::RecordInvalid)
        end

        it 'doesnt accept a gender identifier as a string' do
            user = build(:user, :gender => 'male')
            expect{ user.save! }.to raise_error(ActiveRecord::RecordInvalid)
        end
	end # /context validations

    context 'model methods' do
        
        # Virtual attribute 'name' functions properly
        it 'virtual attribute name returns the users first and last name' do
            user = build(:user, :first_name => "Jack", :last_name => "Johnson")
            expect(user.name).to eq("Jack Johnson")
        end

        # generate_token functions properly
        it 'generates a token properly' do
            user = build(:user, :auth_token => nil)
            user.generate_token
            expect(user.auth_token).to be_present
        end

        # regenerate_auth_token functions properly
        it 'regenerates a token properly' do
            user.generate_token
            token_1 = user.auth_token
            user.regenerate_auth_token
            expect(token_1).to_not eq(user.auth_token)
        end
    end # /context model methods

    context 'dependent destroys' do
        it 'deletes profile when user is deleted' do
            user = create(:user)
            expect{ user.destroy }.to change(Profile, :count).by(-1)
        end
    end
	
end