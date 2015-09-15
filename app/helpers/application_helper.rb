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
