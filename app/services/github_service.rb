class GithubService
  def limited_number_repos
    parse_git_data.take(5)
  end

  private

  def api_connect
    Faraday.new('https://api.github.com') do |conn|
      conn.request :oauth2, '8fc591925fda4649d5c44e0e559265218b18e07e', token_type: :bearer
      conn.adapter Faraday.default_adapter
    end
  end

  def api_return
    api_connect.get('/user/repos')
  end

  def parse_git_data
    JSON.parse(api_return.body, symbolize_names: true)
  end

end
