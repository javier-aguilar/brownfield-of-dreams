module YouTube
  class Playlist
    attr_reader :id, :title, :description, :thumbnail

    def initialize(data = {})
      @id = data[:items].first[:id]
      @title = data[:items].first[:snippet][:title]
      @description = data[:items].first[:snippet][:description]
      @thumbnail = data[:items].first[:snippet][:thumbnails][:high][:url]
    end

    def self.info(id)
      playlist_data = YoutubeService.new.playlist_info(id)
      return if playlist_data[:items].empty?

      new(playlist_data)
    end
  end
end
