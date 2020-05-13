require 'rails_helper'

describe 'User', :vcr do
  before :each do
    @user = create(:user)
    @user2 = create(:user)
    @user.update(token: ENV['GITHUB_TOKEN_2'])
    @user2.update(token: ENV['GITHUB_TOKEN_1'], uid: 53200401)
    visit '/'
    click_on "Sign In"
    fill_in 'session[email]', with: @user.email
    fill_in 'session[password]', with: @user.password
    click_on 'Log In'
  end
  it "can add friend" do
    visit '/dashboard'

    expect(page).to_not have_content("Friends")

    within('.followers') do
      within('#angusshire') do
        expect(page).to_not have_button("Add Friend")
      end

      within('#mlynch5187') do
        expect(page).to have_button("Add Friend")
      end
    end

    within('.following') do
      within('#jashkenas') do
        expect(page).to_not have_button("Add Friend")
      end

      within('#mlynch5187') do
        expect(page).to have_button("Add Friend")
      end
    end

    within('.followers') do
      within('#mlynch5187') do
        click_on("Add Friend")
      end
    end

    expect(page).to have_content("Added friend.")
    expect(page).to have_content("Friends")
    expect(page).to have_content("#{@user2.first_name} #{@user2.last_name}")

    within('.followers') do
      within('#mlynch5187') do
        expect(page).to_not have_button("Add Friend")
      end
    end

    within('.following') do
      within('#mlynch5187') do
        expect(page).to_not have_button("Add Friend")
      end
    end
  end
end
describe 'User', :vcr, type: :request do
  it "cannot add friend with invalid id" do
    post friends_path, params: {id: 9999}
    expect(flash[:error]).to eq "Unable to add friend."
  end
end
