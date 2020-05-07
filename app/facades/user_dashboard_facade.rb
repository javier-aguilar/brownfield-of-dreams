class UserDashboardFacade
  def git_service
    GithubService.new
  end
end
