require 'rails_helper'

describe 'User', :vcr do
  before :each do
    @user = create(:user)
    @user2 = create(:user)
    @tutorial1 = create(:tutorial, title: "How to Tie Your Shoes")
    @video1 = create(:video, title: "The Bunny Ears Technique", tutorial: @tutorial1)
    @video2 = create(:video, title: "The Loop Secret", tutorial: @tutorial1)
    @tutorial2 = create(:tutorial, title: "How to make a cake")
    @video3 = create(:video, title: "Chocolate Cake", tutorial: @tutorial2)
    @video4 = create(:video, title: "Strawberry Cake", tutorial: @tutorial2)
    @video6 = create(:video, title: "Carrot Cake", tutorial: @tutorial2)
    UserVideo.create(user_id: @user2.id, video_id: @video4.id)
    visit '/'
    click_on "Sign In"
    fill_in 'session[email]', with: @user.email
    fill_in 'session[password]', with: @user.password
    click_on 'Log In'
  end
  it "can only see their saved bookmarks on profile ordered by tutorial, position" do
    expect(@user.user_videos).to eq([])

    visit tutorial_path(@tutorial2)
    click_link "#{@video3.title}"
    click_button "Bookmark"
    click_link "#{@video6.title}"
    click_button "Bookmark"

    visit tutorial_path(@tutorial1)

    click_link "#{@video2.title}"
    click_button "Bookmark"

    @user.reload
    expect(@user.user_videos.count).to eq 3

    visit dashboard_path

    within(".bookmarks") do
      expect(page).to_not have_content("#{@video4.title}")
      expect(page.all('li')[0]).to have_content("#{@video2.title}")
      expect(page.all('li')[1]).to have_content("#{@video3.title}")
      expect(page.all('li')[2]).to have_content("#{@video6.title}")
    end
  end
end
