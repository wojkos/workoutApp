class FriendshipsController < ApplicationController
  before_action :authenticate_user!

def show
  @friend = Friendship.find(params[:id]).friend
  @exercises = @friend.exercises
end

def create
  friend = User.find(params[:friend_id])
  params[:user_id] = current_user.id
  Friendship.create!(friendship_params) unless current_user.follow_or_same?(friend)
  redirect_to root_path
end

def destroy
  @friendship = Friendship.find(params[:id])
  friend_name = @friendship.friend.full_name
  if @friendship.destroy
    flash[:notice] = "#{friend_name} unfollowed"
  else
    flash[:notice] = "#{friend_name} could not be unfollowed"
  end
  redirect_to user_exercises_path(current_user)
end

private

# def set_exercise
#   @exercise = current_user.exercises.find(params[:id])
# end

def friendship_params
  params.permit(:friend_id, :user_id)
end
end
