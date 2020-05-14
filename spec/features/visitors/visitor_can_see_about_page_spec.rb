require 'rails_helper'

describe 'Visitor on the show page' do
  it 'can see about information' do
    visit about_path
    expect(page).to have_content("This application is designed to pull in youtube information to populate tutorials from Turing School of Software and Design's youtube channel.")
  end
end
