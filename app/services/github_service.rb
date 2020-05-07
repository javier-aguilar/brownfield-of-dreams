class GithubService
  def limited_number_repos(token)
    get_json(token).take(5)
  end

  private

  def api_connect(token)
    Faraday.new('https://api.github.com') do |conn|
      conn.authorization :Bearer, token
    end
  end

  def get_json(token)
    response = api_connect(token).get('/user/repos')
    JSON.parse(response.body, symbolize_names: true)
  end
end
