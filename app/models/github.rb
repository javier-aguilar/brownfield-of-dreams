module Github
  def self.repos(token)
    data = GithubService.new(token).list_repos.take(5)
    data.map { |repo| Repo.new(repo[:name], repo[:html_url]) }
  end

  def self.followers(token)
    data = GithubService.new(token).list_followers
    data.map { |user| Follower.new(user[:login], user[:html_url]) }
  end

  def self.following(token)
    data = GithubService.new(token).list_following
    data.map { |user| Follower.new(user[:login], user[:html_url]) }
  end
end
