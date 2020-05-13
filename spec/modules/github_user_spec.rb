# spec/models/follower_spec.rb
require "rails_helper"

describe Github::User do
  it "exists" do
    attrs = {
      name: "johndoe",
      url: "https://www.example.com",
      id: 1234,
    }
    repo = Github::User.new(attrs[:id], attrs[:name], attrs[:url])

    expect(repo).to be_a Github::User
    expect(repo.name).to eq("johndoe")
    expect(repo.url).to eq("https://www.example.com")
  end
end
