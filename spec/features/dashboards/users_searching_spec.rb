require "rails_helper"

RSpec.feature "Searching for User" do
  before do
    @john = User.create!(first_name: "John", 
                         last_name: "Doe",
                         email: "john@example.com",
                         password: "password")
                          
    @sarah = User.create!(first_name: "Sarah", 
                          last_name: "Doe",
                          email: "sarah@example.com",
                          password: "password")
    @leo = User.create!(first_name: "Leo", 
                          last_name: "Example",
                          email: "leo@example.com",
                          password: "password")
  end
  
  scenario "with existing name returns only those users" do
    visit '/'
    
    fill_in "search_name", with: "Doe"
    click_button "Search"
    
    expect(page).to have_content(@john.full_name)
    expect(page).to have_content(@sarah.full_name)
    expect(page).not_to have_content(@leo.full_name)
    expect(current_path).to eq("/dashboards/search")
  end

  scenario "with incasesensitive search input" do
    visit '/'
    
    fill_in "search_name", with: "sarah"
    click_button "Search"
    
    expect(page).to have_content(@sarah.full_name)
    expect(page).not_to have_content(@john.full_name)
    expect(page).not_to have_content(@leo.full_name)

    fill_in "search_name", with: "LEO"
    click_button "Search"
    
    expect(page).to have_content(@leo.full_name)
    expect(page).not_to have_content(@john.full_name)
    expect(page).not_to have_content(@sarah.full_name)
  end
 
end