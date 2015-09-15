require 'rails_helper'

feature 'User functionality' do
  
  let(:user){ create(:user) }

  before do
    # go to the home page
    visit root_path
  end

  # Unauthenticated user cannot access other pages
  scenario "user cannot access other pages without signing in" do
    visit profile_posts_path(user)
    expect(current_path).to eq(root_path)
    expect(page).to have_content "Must be signed in to view this page!"
  end

  # Create a new User
  scenario "add a new user" do   
    fill_in('user_first_name', :with => "Trevor")
    fill_in('user_last_name', :with => "Elwell")
    fill_in('user_email', :with => "me@trevorelwell.com")
    fill_in('user_password', :with => "password")
    fill_in('user_password_confirmation', :with => "password")
    select('January', :from => 'birthday_month')
    select('1', :from => 'birthday_day')
    select('1980', :from => 'birthday_year')
    choose('user_gender_1')
    expect{ click_on('Create User') }.to change(User, :count).by(1)
    expect(page).to have_content "User created successfully!"
  end

  # User can login. This functionality will be used via a macro
  # after this explicit test.
  scenario "user can login with valid credentials" do
    fill_in('email', :with => user.email)
    fill_in('password', :with => "password")
    click_on('Login')
    expect(page).to have_content "Successfully logged in!"
    expect(page).to have_content "Howdy, #{user.first_name}"
  end

  # TODO: This one doesn't seem to be working right.
  # Perhaps because the @user variable isn't setup yet?
  scenario "user cannot login with wrong password" do
    fill_in('email', :with => user.email)
    fill_in('password', :with => "not_password")
    click_on('Login')
    expect(page).to have_content "Couldn't log you in, please try again."
  end

  # This is the initial test, signing out is now
  # delegated to the login macros.
  scenario "user can logout" do
    sign_in(user)
    click_link("Logout")
    expect(page).to have_content "You've been signed out."
  end

  scenario "user can edit profile" do
    sign_in(user)
    # Scope!
    within("#about_header") do
      click_link("Edit Profile")
    end
    fill_in('profile_words_to_live_by', :with => "Look, it changed!")
    click_button("Update Profile")
    expect(page).to have_content "Look, it changed!"
    expect(page).to have_content "Profile updated!"
  end

  # This is going to be delegated to a macro as well
  scenario "user can post on their own timeline" do
    sign_in(user)
    visit profile_posts_path(user)
    fill_in('post_content', :with => "This is my test post!")
    expect{ click_button("Post") }.to change(Post, :count).by(1)
    expect(page).to have_content("Post created successfully!")
  end

  scenario "user cannot post on another user's timeline" do
    another_user = create(:user_with_post_like, :first_name => "Another", :last_name => "User")
    sign_in_with_post(user)
    visit profile_posts_path(another_user)
    expect(page).to_not have_content("Post on your timeline")
  end

  scenario "user can like their own post" do
    sign_in_with_post(user)
    expect{ click_link("Like") }.to change(Like, :count).by(1)
    expect(page).to have_content("Liked!")
  end

  scenario "user can UNlike a post" do
    sign_in_with_post(user)
    click_link("Like")
    expect{ click_link("Unlike") }.to change(Like, :count).by(-1)
    expect(page).to have_content("Unliked!")
  end

  scenario "user can like someone else's post" do
    another_user = create(:user_with_post_like, :first_name => "Another", :last_name => "User")
    sign_in_with_post(user)
    visit profile_posts_path(another_user)
    expect{ click_link("Like") }.to change(Like, :count).by(1)
    expect(page).to have_content("Liked!")
  end

end