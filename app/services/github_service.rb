class GithubService
  def initialize(token)
    @token = token
  end

  def list_repos
    get_json('/user/repos')
  end

  def list_followers
    get_json('/user/followers')
  end

  def list_following
    get_json('/user/following')
  end

  private

  def get_json(url, params = nil)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new('https://api.github.com') do |conn|
      conn.authorization :Bearer, @token
    end
  end
end
