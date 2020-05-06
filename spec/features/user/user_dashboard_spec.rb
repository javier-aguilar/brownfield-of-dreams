require 'rails_helper'

feature "A user visiting the admin dashboard" do
  scenario "can see 5 repos" do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/user/dashboard"

    expect(page).to have_css(".user-repo-list")
    expect(page).to have_css(".user-repo-link", count: 5)

    expect(page).to have_link("futbol")
    expect(page).to have_css('a[href="https://github.com/iEv0lv3/futbol"]')

    expect(page).to have_link("brownfield-of-dreams")
    expect(page).to have_css('a[href="https://github.com/javier-aguilar/brownfield-of-dreams"]')

    expect(page).to have_link("alpha_paradigms_academy")
    expect(page).to have_css('a[href="https://github.com/quiet-storm/alpha_paradigms_academy"]')

    expect(page).to have_link("metaphysics")
    expect(page).to have_css('a[href="https://github.com/quiet-storm/metaphysics"]')

    expect(page).to have_link("metaphysics-dev")
    expect(page).to have_css('a[href="https://github.com/quiet-storm/metaphysics-dev"]')
  end
end
