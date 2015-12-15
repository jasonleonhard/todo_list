require 'spec_helper'
require 'capybara/rspec'


describe "Creating todo lists" do
  it "redirects to the todo list index page on success" do
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")
        
    fill_in "Title", with: "Example todo list"
    fill_in "Description", with: "This is what I have to say for now"
    click_button "Create Todo list"
    expect(page).to have_content("Todo list was successfully created.")
  end
end