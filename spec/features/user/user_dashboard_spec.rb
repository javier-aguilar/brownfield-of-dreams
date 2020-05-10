require 'rails_helper'

describe 'User' do
  before :each do
    @user = create(:user)
    @user2 = create(:user)
    visit '/'
    click_on "Sign In"
    fill_in 'session[email]', with: @user.email
    fill_in 'session[password]', with: @user.password
    click_on 'Log In'
  end
  it "once logged in, cannot see repositories if missing token" do
    visit '/dashboard'

    expect(page).to have_no_content("Github")

    expect(page).to_not have_link("futbol")
    expect(page).to_not have_link("brownfield-of-dreams")
    expect(page).to_not have_link("alpha_paradigms_academy")
    expect(page).to_not have_link("metaphysics")
    expect(page).to_not have_link("metaphysics-dev")
  end
  it "once logged in, can see their repositories if they have a token" do
    @user.update(token: ENV['GITHUB_TOKEN_1'])
    @user2.update(token: ENV['GITHUB_TOKEN_2'])

    visit '/dashboard'

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
  it "once logged in, I should see a section called 'Followers' with a list of
      users followers" do
      @user.update(token: ENV['GITHUB_TOKEN_1'])

      visit '/dashboard'

      expect(page).to have_content("Followers")

      expect(page).to have_link("strafe")
      expect(page).to have_css('a[href="https://github.com/strafe"]')

      expect(page).to have_link("alex-latham")
      expect(page).to have_css('a[href="https://github.com/alex-latham"]')

      expect(page).to have_link("mlynch5187")
      expect(page).to have_css('a[href="https://github.com/mlynch5187"]')

      expect(page).to have_link("DavidTTran")
      expect(page).to have_css('a[href="https://github.com/DavidTTran"]')

      expect(page).to have_link("tylertomlinson")
      expect(page).to have_css('a[href="https://github.com/tylertomlinson"]')
  end
  it "once logged in, I should see a section called 'Following' with a list of
      users followers" do
      @user.update(token: ENV['GITHUB_TOKEN_1'])

      visit '/dashboard'

      expect(page).to have_content("Following")

      expect(page).to have_link("disconnectme")
      expect(page).to have_css('a[href="https://github.com/disconnectme"]')
  end
end
