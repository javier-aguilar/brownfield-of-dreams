require 'rails_helper'

feature "As an admin" do
  scenario "I can edit a video's info" do
    admin = create(:user, role: 1)
    tutorial = create(:tutorial)
    video1 = create(:video, tutorial_id: tutorial.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit edit_admin_video_path(video1)

    fill_in'video[title]', with: "Hello World!"
    fill_in'video[description]', with: "Intro into ruby"
    click_on 'Save'

    expect(Video.last.title).to eq "Hello World!"
    expect(Video.last.description).to eq "Intro into ruby"
  end
end
