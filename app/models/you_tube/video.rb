module YouTube
  class Video
    attr_reader :id, :title, :description, :thumbnail

    def initialize(data = {})
      @id = data[:items].first[:id]
      @title = data[:items].first[:snippet][:title]
      @description = data[:items].first[:snippet][:description]
      @thumbnail = data[:items].first[:snippet][:thumbnails][:high][:url]
    end

    def self.by_id(id)
      new(YoutubeService.new.video_info(id))
    end

    def self.by_playlist(id)
      playlist_data = YoutubeService.new.playlist_videos(id)
      return if playlist_data.nil?

      playlist_data.map do |video|
        new(YoutubeService.new.video_info(video[:contentDetails][:videoId]))
      end
    end
  end
end
