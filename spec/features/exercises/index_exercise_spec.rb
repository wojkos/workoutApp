require "rails_helper"

RSpec.feature "Listing Exercises" do
  before do
    @john =  User.create(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password")
    @sarah = User.create(first_name: "Sarah", last_name: "Anderson", email: "sarah@example.com", password: "password")
    
    login_as(@john)
    
    @e1 = @john.exercises.create(duration: 20,
                                  workout: "My body building activity",
                                  workout_date: Date.today)
                                  
    @e2 = @john.exercises.create(duration: 55,
                                  workout: "Weight lifting",
                                  workout_date: 2.days.ago)
                                  
    # @following = Friendship.create(user: @john, friend: @sarah)

  end
  
  scenario "shows user's workout for last 7 days" do
    visit '/'
    
    click_link "My Lounge"
    
    expect(page).to have_content(@e1.duration)
    expect(page).to have_content(@e1.workout)
    expect(page).to have_content(@e1.workout_date)
    
    expect(page).to have_content(@e2.duration)
    expect(page).to have_content(@e2.workout)
    expect(page).to have_content(@e2.workout_date)

  end
  
  scenario "shows no exercises if none created" do
    @john.exercises.delete_all
    
    visit '/'
    
    click_link 'My Lounge'
    
    expect(page).to have_content('No Workouts Yet')
  end
  
  # scenario "shows a list of user's friends" do
  #   visit "/"
    
  #   click_link "My Lounge"
  #   expect(page).to have_content("My Friends")
  #   expect(page).to have_link(@sarah.full_name)
  #   expect(page).to have_link("Unfollow")
  # end
  
end