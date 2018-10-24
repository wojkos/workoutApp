class ExercisesController < ApplicationController 
  
  def index
    @exercises = current_user.exercises.all
  end

  def show
    @exercise = current_user.exercises.find(params[:id])
  end

  def new
    @exercise = current_user.exercises.new
  end

  def create
    @exercise = current_user.exercises.new(exercise_params)

    if @exercise.save
      flash[:notice] = 'Exercise has been created'
      redirect_to [current_user, @exercise]
    else
      flash.now[:alert] = 'Exercise has not been created'
      render :new
    end
  end 

  private

  def exercise_params
    params.require(:exercise).permit(:duration, :workout, :workout_date, :user_id)
  end
end
