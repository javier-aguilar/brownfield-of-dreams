class GithubsController < ApplicationController
  def create
    response = request.env['omniauth.auth']
    current_user.update(github_params(response))
    redirect_to dashboard_path
  end

  private

  def github_params(response)
    { uid: response[:uid],
      token: response[:credentials][:token] }
  end
end
