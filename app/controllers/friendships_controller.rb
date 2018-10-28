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
end

private

# def set_exercise
#   @exercise = current_user.exercises.find(params[:id])
# end

def friendship_params
  params.permit(:friend_id, :user_id)
end
end
