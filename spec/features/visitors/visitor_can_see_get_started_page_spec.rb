require 'rails_helper'

describe 'Visitor on the get started page' do
  it 'can see information about getting started' do
    visit get_started_path
    expect(page).to have_content("Browse tutorials from the homepage.")
    expect(page).to have_link("homepage")
  end
end
