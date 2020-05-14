require 'rails_helper'

describe "An Admin can edit a tutorial" do
  let(:tutorial) { create(:tutorial) }
  let(:admin)    { create(:admin) }

  scenario "by adding a video", :js, :vcr do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit edit_admin_tutorial_path(tutorial)

    click_on "Add Video"

    fill_in "video[title]", with: "How to tie your shoes."
    fill_in "video[description]", with: "Over, under, around and through, Meet Mr. Bunny Rabbit, pull and through."
    fill_in "video[video_id]", with: "J7ikFUlkP_k"
    click_on "Create Video"

    expect(current_path).to eq(edit_admin_tutorial_path(tutorial))

    within(first(".video")) do
      expect(page).to have_content("How to tie your shoes.")
    end
  end
  scenario "by changing a video's position", :js, type: :request do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    tutorial = create(:tutorial)
    vid1 = create(:video, tutorial_id: tutorial.id)
    expect(vid1.position).to eq 0

    patch admin_video_path(vid1), params: {position: 4}

    vid1.reload
    expect(vid1.position).to eq 4
  end
end
