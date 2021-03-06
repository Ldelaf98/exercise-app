class HomepageController < AuthenticationController

  public
  
  def new
  end
  
  def show
    puts("showing the progress")
  end


  def dashboard
    puts("dashboard showing")
    
    @data = Goal.day_by_value(current_effective_user)
    
    @goals = Goal.where(user_id: session[:effective_id])
    @goal_data = Array.new
    @goal_names = Array.new
    @goal_progress = Array.new
    new_rep_value = 0
    @goals.each do |g|
      # byebug
      goal_values = Array.new
      current_effective_user.workout.each do | workout |
        workout.task.each do |task|
          # puts "G unit name: "
          # puts g.unit.name
          if task.exercise_id == g.exercise_id then
            task.exercise_set.each do | exercise_set |
              if exercise_set.rep_unit == g.unit.name then
                goal_values.push(Array.new([exercise_set.created_at.strftime("%D %H:%M"), exercise_set.rep_value]))
              
              # future work -> convert this BS into a function
              elsif g.unit.category == "Cardio" then
              
                if g.unit.name == "meters" then
                  # 1 miles -> 1609.34 meters
                  if exercise_set.rep_unit == "miles" then
                    new_rep_value = exercise_set.rep_value * 1609.34
                  end
                elsif g.unit.name == "miles" then
                  # 1 meter -> 0.000621371 miles
                  if exercise_set.rep_unit == "meters" then
                    new_rep_value = exercise_set.rep_value * 0.0006
                  end
                end
                
                if g.unit.name == "hours" then
                  # 1 minute -> 0.0166667 hours
                  if exercise_set.rep_unit == "minutes" then
                    new_rep_value = exercise_set.rep_value * 0.017
                  end
                  # 1 second -> 0.000277778 hours
                  if exercise_set.rep_unit == "seconds" then
                    new_rep_value = exercise_set.rep_value * 0.0003
                  end
                elsif g.unit.name == "minutes" then
                  # 1 hour -> 60 minutes
                  if exercise_set.rep_unit == "hours" then
                    new_rep_value = exercise_set.rep_value * 60
                  end
                  # 1 second -> 0.0166667 minutes
                  if exercise_set.rep_unit == "seconds" then
                    new_rep_value = exercise_set.rep_value * 0.017
                  end
                elsif g.unit.name == "seconds" then
                  # 1 hour -> 3600 seconds
                  if exercise_set.rep_unit == "hours" then
                    new_rep_value = exercise_set.rep_value * 3600
                  end
                  # 1 minute -> 60 seconds
                  if exercise_set.rep_unit == "minutes" then
                    new_rep_value = exercise_set.rep_value * 60
                  end
                end
                
                goal_values.push(Array.new([exercise_set.created_at.strftime("%D %H:%M"), new_rep_value]))
         
              elsif g.unit.category == "Strength" then
                             
                if g.unit.name == "lbs" then
                  # 1 kg -> 2.20462 lb
                  if exercise_set.rep_unit == "kgs" then
                    new_rep_value = exercise_set.rep_value * 2.20462
                  end
                elsif g.unit.name == "kgs" then
                  # 1 lb -> 0.453592 kg
                  if exercise_set.rep_unit == "lbs" then
                    new_rep_value = exercise_set.rep_value * 0.453592
                  end
                end
                goal_values.push(Array.new([exercise_set.created_at.strftime("%D %H:%M"), new_rep_value]))
              end
            end
          end
        end
      end

      @goals = [] if (@goals.nil?)
  
      rep_values = goal_values.map(&:last)
      @progress = (rep_values.max.to_f/g.value.to_f)*100.to_f
      
      @goal_data.push(goal_values)
      @goal_progress.push(@progress.to_i)
        
    end
    @goals = [] if (@goals.nil?)
  end
  
  def my_measurement
    puts("Displaying my measurements page")
  end
  
  def my_workout
    puts("Displaying my workout page")
  end
  
  def my_goals
    puts("my recent goal")
  end 
  
  def homepage
    puts("go back to the homepage")
  
  end
  
  def quick_log
    puts("Displaying quick log page...")
    @exercises = Exercise.all
    @exercises = [] if (@exercises.nil?)
    
    puts("Displaying user's workouts...")
    @current_effective_user = current_effective_user()
    
    @workouts = @current_effective_user.workout
    @workouts = [] if (@workouts.nil?)
  end
  
  def process_new_quick_log
    puts("Creating new quick log...")
    puts("="*100)
    user = current_effective_user
    workout_name = "Workout_" + current_effective_user.id.to_s + "_" + Time.now.to_s
    task_card_data = params[:task_card_data]
    Workout.insert_new_workout(user, workout_name, task_card_data, State.complete, State.complete, State.complete)
    head :ok, content_type: "text/html"
  end
  
  def view_exercises
    puts("Displaying view exercises page")
    @exercises = Exercise.all
    @units = Unit.all
  end
  
    
  
end
