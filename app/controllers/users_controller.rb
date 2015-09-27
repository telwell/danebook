class UsersController < ApplicationController
	
	# TODO: Redirect user to homepage if not 
	# logged in viewing profiles

	skip_before_filter :must_be_signed_in, :only => [:new, :create]
	before_filter :redirect_signed_in_user, :only => [:new]
	
	def new
		@user = User.new
		if signed_in_user?
			@profile = current_user.profile
		end
	end

	def create
		@user = User.new(user_params)
		@user.birthday = convert_birthday(params)
		if @user.save
			flash[:success] = "User created successfully!"
			sign_in(@user)
			
			# Once the user is created we'll want to create a blank
			# profile for them.
			# TODO: Move this to the User model as an after(:create) so 
			# that the whole thing blows up if the profile fails.
			Profile.create(:user_id => @user.id)
			
			# TODO: Redirect to profile_path
			redirect_to profile_path(@user.profile)
		else
			flash[:error] = "Failed to create user"
			render :new
		end
	end

	# QUESTION: This doesn't seem like the best way to do this, perhaps
	# using a custom route? I wanted to stay RESTful but think that this
	# might be a place where it makes sense not to.
	def update
		@user = User.find(params[:id])
		if params[:avatar_photo]
			@user.avatar_id =  params[:avatar_photo].to_i
		elsif params[:cover_photo]
			@user.cover_photo_id =  params[:cover_photo].to_i
		end

		if @user.save
			flash[:success] = "Photo Set!"
			redirect_to request.referrer
		else
			flash[:error] = "Couldn't set photo!"
			redirect_to request.referrer
		end
	end


private
	
	def user_params
		params.require(:user).
					permit(:first_name,
									:last_name, 
									:email, 
									:password,
									:password_confirmation,
									:birthday_year,
									:birthday_month,
									:birthday_day,
									:gender, 
									:avatar_id, 
									:cover_photo_id
					)
	end

	# Convert birthday into a meaningful date from the form.
	def convert_birthday(params)
		if params[:birthday_year].nil? || params[:birthday_month].nil? || params[:birthday_day].nil?
			nil
		else
			Date.parse("#{params[:birthday_year]}-#{params[:birthday_month]}-#{params[:birthday_day]}")
		end
	end

	def redirect_signed_in_user
		redirect_to profile_newsfeed_path(current_user.profile) if signed_in_user?
	end

end