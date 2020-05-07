require 'rails_helper'

describe GithubService do
  before(:each) do
    @user = create(:user)
    @user.update(token: ENV['GITHUB_TOKEN_1'])
    @token = @user[:token]
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    @presenter = UserDashboardFacade.new
    @service = @presenter.git_service
  end

  it "exists" do
    expect(@service.class).to eq(GithubService)
  end

  context 'instance methods' do
    it 'limited_number_repos' do
      expect(@service.limited_number_repos(@token).count).to eq(5)
      expect(@service.limited_number_repos(@token).class).to eq(Array)
      expect(@service.limited_number_repos(@token).first.class).to eq(Hash)
    end
  end
end
