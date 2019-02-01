# Taken from the cucumber-rails project.

module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'

    when /the winning page/
      '/win'
    when /the losing page/
      '/lose'
    when /the show page/
      '/show'
    when /the my measurements page/
      '/my_measurements'
      
    when /the enter measurements page/
      '/enter_my_measurements'
      
    when /the dashboard page/
      '/dashboard'
      
    when /the my goals page/
      '/my_goals'
      
    when /the my client page/
      '/my_clients'
      
    when /the my workouts page/
      '/my_workouts'
      
    when /the splash screen page/
      '/splash_screen'
 
    when /the create workout page/
      '/create_workout'
      
    when /the create exercise page/
      '/create_exercise'

      
    when /the enter goal page/
      '/enter_goal'
      
    when /the view exercises page/
      '/view_exercises'


    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
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
