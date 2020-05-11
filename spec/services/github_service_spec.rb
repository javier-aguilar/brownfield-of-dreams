# /spec/services/github_service_spec.rb
require 'rails_helper'

describe GithubService do
  context "instance methods" do
    context "#list_repos" do
      it "returns repo data", :vcr do
        repos = GithubService.new(ENV['GITHUB_TOKEN_1']).list_repos
        expect(repos).to be_an Array
        repo_data = repos.first

        expect(repo_data).to have_key :name
        expect(repo_data).to have_key :html_url
      end
    end
    context "#list_followers" do
      it "returns follower data", :vcr do
        followers = GithubService.new(ENV['GITHUB_TOKEN_1']).list_followers
        expect(followers).to be_an Array
        follower_data = followers.first

        expect(follower_data).to have_key :login
        expect(follower_data).to have_key :html_url
      end
    end
    context "#list_following" do
      it "returns following data", :vcr do
        following = GithubService.new(ENV['GITHUB_TOKEN_1']).list_following
        expect(following).to be_an Array
        following_data = following.first

        expect(following_data).to have_key :login
        expect(following_data).to have_key :html_url
      end
    end
  end
end
