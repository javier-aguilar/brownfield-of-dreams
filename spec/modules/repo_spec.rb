# spec/models/repo_spec.rb
require "rails_helper"

describe Github::Repo do
  it "exists" do
    attrs = {
      name: "My First Repo",
      url: "https://www.example.com"
    }
    repo = Github::Repo.new(attrs[:name], attrs[:url])

    expect(repo).to be_a Github::Repo
    expect(repo.name).to eq("My First Repo")
    expect(repo.url).to eq("https://www.example.com")
  end
end
