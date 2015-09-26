module ApplicationHelper


  # Whatever item is passed must have an 
  # :author association on it.
  def belongs_to_current_user?(item)
    !!(@current_user.id == item.author.id)
  end


  # TODO: This can be cleaned up. It's used in 
  # _header.html.erb to determine whether or not
  # the 'Edit Profile' link/button should show up.
  def belongs_to_current_profile_user?
    !!(@current_user.id == @user.id)
  end


  # Give us the title of the current page
  def get_page_name
    controller_name == "profiles" ? "About" : controller_name.titleize
  end


  # QUESTION: While implimenting view testing I discovered that the 
  # controller_name changed to "test". This resulted in me needing to
  # create some new logic to show the 'Edit Profile' button on the profile
  # pages.
  def profile_show_page?
    controller_name == "profiles"
  end


  # This helper will return true if the profile of the current user
  # has been friended by the current user. False otherwise.
  def friend_of_current_user?
    current_user.friends.pluck(:id).include?(@profile.user.id) ? 
    current_user.friendships.find_by_friend_id(@profile.user.id) : false
  end

  def friend_of_current_user(user)
    current_user.friends.pluck(:id).include?(user.id) ? 
    true : false
  end


  # Pass in the user object which you'd like to determine is friends with 
  # the current_user or not. Returns the friendship ID if they are.
  def get_friendship_id(user)
  	Friendship.where("user_id = ? AND friend_id = ?", current_user.id, user.id).first.id
  end


  # Will return the proper action button for our various
  # pages. Add/Remove Friend, Edit Profile, Add Photo.
  # TODO: Would make sense to make this into my switchboard and 
  # call the other action button methods from here. 
  def which_action_button?
    if belongs_to_current_profile_user?
      if controller_name == 'photos'
        link_to "Add New Photo", new_profile_photo_path(@profile), class: "btn btn-primary inline pull-right"
      elsif controller_name == 'profiles'        
        link_to "Edit Profile", edit_profile_path(@current_user.profile), class: "btn btn-info inline pull-right"
      end
    else
      if friendship_id = friend_of_current_user?
        link_to "Remove Friend", profile_friendship_path(:profile_id => @profile, :id => friendship_id), method: :delete, class: "btn btn-danger inline pull-right"
      else
        #We don't want to show this on our own profile
        unless belongs_to_current_profile_user?
          link_to "Add Friend", profile_friendships_path(@profile), method: :post, class: "btn btn-success inline pull-right"
        end
      end
    end
  end


  # Get the avatar for a given user.
  def user_avatar(user)
    user.avatar ? user.avatar.photo.url(:thumb) : "default-avatar.jpg"
  end


  # Get the cover photo for a given user.
  def user_cover_photo(user)
    user.cover_photo.present? ? user.cover_photo.photo.url : "default-cover-image.jpg"
  end


	def bootstrap_class_for flash_type
    case flash_type
      when :success
        "alert-success" # Green
      when :error
        "alert-danger" # Red
      when :alert
        "alert-warning" # Yellow
      when :notice
        "alert-info" # Blue
      else
        "alert-warning" # Set warning as the default
    end
  end

end
