require 'rails_helper'

describe GithubService do
  before(:each) do
    @user = create(:user)
    @user.update(token: ENV['GITHUB_TOKEN_1'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    # @presenter = UserDashboardFacade.new
  end

  it "exists" do
    # sequence = [vid_1.id, vid_2.id, vid_3.id]
    # tutorial_sequencer = TutorialSequencer.new(tutorial, sequence)
    # expect(tutorial_sequencer).to be_a TutorialSequencer
  end

  context 'instance methods' do
    context 'Github API' do
      it 'can connect to Github API' do
        expect(@user.api_connect.class).to eq(Faraday::Connection)
      end

      # it 'can return API data' do
      #   expect(@presenter.api_return.class).to eq(Faraday::Response)
      # end

      # it 'can parse API data' do
      #   expect(@presenter.get_json.class).to eq(Array)
      #   expect(@presenter.get_json.first.class).to eq(Hash)
      # end

      # context 'user repos' do
      #   it 'can limit return to 5 repos' do
      #     expect(@presenter.limited_number_repos.count).to eq(5)
      #     expect(@presenter.limited_number_repos.class).to eq(Array)
      #     expect(@presenter.limited_number_repos.first.class).to eq(Hash)
      #   end
      # end
    end
  end
end
