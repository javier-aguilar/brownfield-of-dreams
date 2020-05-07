# spec/models/follower_spec.rb
require "rails_helper"

describe Github do
  it "#repos" do
    repos = Github.repos(ENV['GITHUB_TOKEN_1'])
    repo_data = repos.first

    expect(repo_data).to have_attributes(name: 'futbol')
    expect(repo_data).to have_attributes(url: 'https://github.com/iEv0lv3/futbol')
  end
  it "#followers" do
    followers = Github.followers(ENV['GITHUB_TOKEN_1'])
    follower_data = followers.first

    expect(follower_data).to have_attributes(name: 'strafe')
    expect(follower_data).to have_attributes(url: 'https://github.com/strafe')
  end
  it "#following" do
    following = Github.following(ENV['GITHUB_TOKEN_1'])
    following_data = following.first

    expect(following_data).to have_attributes(name: 'disconnectme')
    expect(following_data).to have_attributes(url: 'https://github.com/disconnectme')
  end
end
