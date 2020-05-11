require 'rails_helper'

describe 'As an admin'
  describe 'When I visit /admin/tutorials/new' do
    it 'I can import a YouTube playlist by filling a form', :vcr do
      admin = create(:user, role: 1)
      playlist_id = 'PLBO8M-O_dTPEdv9xixE4oH1hequU63wpJ'

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit new_admin_tutorial_path

      click_on 'Import Youtube Playlist'

      fill_in'tutorial[playlist_id]', with: playlist_id
      click_on 'Import'

      expect(current_path).to eq admin_dashboard_path
      expect(page).to have_content("Successfully created tutorial. View it here.")
      click_on "View it here"

      expect(current_path).to eq tutorial_path(Tutorial.last)

      within('.tutorials') do
        expect(page).to have_content('The Best of DidYouKnowGaming!')
      end

      expect(page).to have_selector('li', count: 84)
      within('ul') do
        expect(page.all('li').first).to have_content("A Complete History of Pokemon Rumors - Did You Know Gaming? Feat. Remix")
        expect(page.all('li')[6]).to have_content("Pokemon Heart Gold and Soul Silver - Did You Know Gaming? Feat. Dazz")
        expect(page.all('li')[11]).to have_content("Pokemon Ruby & Sapphire - Did You Know Gaming? Feat. Furst")
        expect(page.all('li').last).to have_content("Every Cancelled N64 Game - Did You Know Gaming? Ft. Remix (South Park 2, Doom Absolution + more.)")
      end
    end
end
