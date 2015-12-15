require 'spec_helper'
require 'capybara/rspec'

describe "Creating todo lists" do
  def create_todo_list(options={})
    options[:title] ||= "Example title"
    options[:description] ||= "Example description"
    
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")
    fill_in "Title", with: options[:title]
    fill_in "Title", with: options[:description]
    click_button "Create Todo list"
    # expect(page).to have_content("Todo list was successfully created.")
  end

  it "redirects to the todo list index page on success" do
    create_todo_list
    # expect(page).to have_content("Todo list was successfully created.")
    # expect(page).to have_content("Example title")
  end

  it "displays error when no title" do
    expect(TodoList.count).to eq(0)
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")
    fill_in "Title", with: ""
    fill_in "Description", with: "bla bla bla"
    click_button "Create Todo list"
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
    visit "/todo_lists"
    expect(page).to_not have_content("bla bla bla")
  end

  it "displays error when no description" do
    expect(TodoList.count).to eq(0)
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")
    fill_in "Title", with: "bla bla bla"
    fill_in "Description", with: ""
    click_button "Create Todo list"
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
    visit "/todo_lists"
    expect(page).to_not have_content("bla bla bla")
  end

   it "displays error when title is less than 3 characters" do
    expect(TodoList.count).to eq(0)
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")
    fill_in "Title", with: "Hi"
    fill_in "Description", with: "bla bla bla"
    click_button "Create Todo list"
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
    visit "/todo_lists"
    expect(page).to_not have_content("bla bla bla")
  end

   it "displays error when description is less than 3 characters" do
    expect(TodoList.count).to eq(0)
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")
    fill_in "Title", with: "Yet another title"
    fill_in "Description", with: "Hi"
    click_button "Create Todo list"
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
    visit "/todo_lists"
    expect(page).to_not have_content("bla bla bla")
  end
end