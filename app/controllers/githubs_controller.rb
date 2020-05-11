class GithubsController < ApplicationController
  def create
    response = request.env['omniauth.auth']
    current_user.update(token: github_params(response))
    redirect_to dashboard_path
  end

  private

  def github_params(response)
    response["credentials"]["token"]
  end
end
