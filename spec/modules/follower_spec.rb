# spec/models/follower_spec.rb
require "rails_helper"

describe Github::Follower do
  it "exists" do
    attrs = {
      name: "johndoe",
      url: "https://www.example.com"
    }
    repo = Github::Follower.new(attrs[:name], attrs[:url])

    expect(repo).to be_a Github::Follower
    expect(repo.name).to eq("johndoe")
    expect(repo.url).to eq("https://www.example.com")
  end
end
