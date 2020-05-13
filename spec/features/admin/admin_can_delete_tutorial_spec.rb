require 'rails_helper'

feature "An admin can delete a tutorial" do
  scenario "and it should no longer exist", :vcr do
    admin = create(:admin)

    create_list(:tutorial, 2)
    tutorial = Tutorial.last
    vid1 = Video.create!({
      "title"=>"Prework - Environment Setup",
      "description"=> Faker::Hipster.paragraph(sentence_count: 2, supplemental: true),
      "video_id"=>"qMkRHW9zE1c",
      "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
      "position"=>1,
      "tutorial_id" => tutorial.id
    })
    vid2 = Video.create!({
      "title"=>"Prework - SSH Key Setup",
      "description"=> Faker::Hipster.paragraph(sentence_count: 2, supplemental: true),
      "video_id"=>"XsPVWGKK0qI",
      "thumbnail"=>"https://i.ytimg.com/vi/XsPVWGKK0qI/hqdefault.jpg",
      "position"=>2,
      "tutorial_id" => tutorial.id
    })
    vid3 = Video.create!({
      "title"=>"Prework - Strings",
      "description"=> Faker::Hipster.paragraph(sentence_count: 2, supplemental: true),
      "video_id"=>"iXLwXvev4X8",
      "thumbnail"=>"https://i.ytimg.com/vi/iXLwXvev4X8/hqdefault.jpg",
      "position"=>3,
      "tutorial_id" => tutorial.id
    })
    vid4 = Video.create!({
      "title"=>"Prework - Arrays",
      "description"=> Faker::Hipster.paragraph(sentence_count: 2, supplemental: true),
      "video_id"=>"c2UnIQ3LRnM",
      "thumbnail"=>"https://i.ytimg.com/vi/c2UnIQ3LRnM/hqdefault.jpg",
      "position"=>4,
      "tutorial_id" => tutorial.id
    })
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    expect(tutorial.videos).to include(vid1, vid2, vid3, vid4)

    expect(page).to have_css('.admin-tutorial-card', count: 2)

    within("##{tutorial.id}") do
      click_on 'Delete'
    end

    expect(Tutorial.all).to_not include(tutorial)
    expect(Video.all).to_not include(vid1, vid2, vid3, vid4)

    expect(page).to have_css('.admin-tutorial-card', count: 1)
  end
end
