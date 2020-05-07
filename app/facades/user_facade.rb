class UserFacade < SimpleDelegator
  def repos
    Github.repos(token)
  end

  def followers
    Github.followers(token)
  end

  def following
    Github.following(token)
  end
end
