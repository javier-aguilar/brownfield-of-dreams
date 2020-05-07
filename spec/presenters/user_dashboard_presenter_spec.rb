require 'rails_helper'

describe UserDashboardFacade do
  before(:each) do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    @presenter = UserDashboardFacade.new
  end

  it 'exists' do
    expect(@presenter.class).to eq(UserDashboardFacade)
  end

  describe 'instance methods' do
    it 'can connect to GithubService' do
      expect(@presenter.git_service.class).to eq(GithubService)
    end
  end
end
