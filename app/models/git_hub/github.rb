module Github
  class Repo
    attr_reader :name, :url

    def initialize(name, url)
      @name = name
      @url = url
    end

    def self.list_repos(token)
      new(GithubService.new.limited_number_repos(token))
    end
  end
end
