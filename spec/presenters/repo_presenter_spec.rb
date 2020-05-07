require 'rails_helper'

describe UserDashboardFacade do
  before(:each) do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    @presenter = UserDashboardFacade.new
  end

  describe 'instance methods' do
    it 'can connect to Github API' do
      expect(@presenter.api_connect.class).to eq(Faraday::Connection)
    end

    it 'can return API data' do
      expect(@presenter.api_return.class).to eq(Faraday::Response)
    end

    it 'can parse API data' do
      expect(@presenter.parse_git_data.class).to eq(Array)
      expect(@presenter.parse_git_data.first.class).to eq(Hash)
    end

    it 'can limit return to 5 repos' do
      expect(@presenter.limited_number_repos.count).to eq(5)
      expect(@presenter.limited_number_repos.class).to eq(Array)
      expect(@presenter.limited_number_repos.first.class).to eq(Hash)
    end
  end
end
