require 'rails_helper'

feature "A user visiting the user dashboard" do
  scenario "can see 5 repos" do
    user = create(:user)

    visit '/'
    click_on "Sign In"
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_on 'Log In'

    user.update(token: ENV['GITHUB_TOKEN_1'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/user/dashboard"

    expect(page).to have_css(".user-repo-list")
    expect(page).to have_css(".user-repo-link", count: 5)

    expect(page).to have_link("futbol")
    expect(page).to have_css('a[href="https://github.com/iEv0lv3/futbol"]')

    expect(page).to have_link("brownfield-of-dreams")
    expect(page).to have_css('a[href="https://github.com/javier-aguilar/brownfield-of-dreams"]')

    expect(page).to have_link("adopt_dont_shop_2001")
    expect(page).to have_css('a[href="https://github.com/tony-gomes/adopt_dont_shop_2001"]')

    expect(page).to have_link("adopt_dont_shop_2001_three_amigos")
    expect(page).to have_css('a[href="https://github.com/tony-gomes/adopt_dont_shop_2001_three_amigos"]')

    expect(page).to have_link("b2-mid-mod")
    expect(page).to have_css('a[href="https://github.com/tony-gomes/b2-mid-mod"]')
  end
end
