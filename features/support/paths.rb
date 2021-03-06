module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the homepage/
      '/'
    when /sign up/
      new_user_path
    when /log in/
      new_session_path
    when /(?:the )?about page/
      brochure_path :page => 'about'
    when /(.+)'s new item page$/i
      new_user_item_path(User.find_by_login($1))
    when /(.+)'s home page$/i
      user_path(User.find_by_login($1))
    
    # Add more mappings here.
    # Here is a more fancy example:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
