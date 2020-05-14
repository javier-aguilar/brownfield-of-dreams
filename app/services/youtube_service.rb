class YoutubeService
  def video_info(id)
    params = { part: 'snippet,contentDetails,statistics', id: id }
    get_json('youtube/v3/videos', params)
  end

  def playlist_info(id)
    params = { part: 'snippet', id: id }
    get_json('https://www.googleapis.com/youtube/v3/playlists', params)
  end

  def playlist_videos(id)
    params = { part: 'snippet,contentDetails', playlistId: id, maxResults: 40 }
    data = get_json('youtube/v3/playlistItems', params)
    return unless data[:nextPageToken]

    next_playlist_items(params, data)
  end

  private

  def next_playlist_items(params, data)
    while data[:nextPageToken]
      params[:pageToken] = data[:nextPageToken]
      results = get_json('youtube/v3/playlistItems', params)
      data[:items] += results[:items]
      data[:nextPageToken] = results[:nextPageToken]
    end
    data
  end

  def get_json(url, params)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://www.googleapis.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['YOUTUBE_API_KEY']
    end
  end
end
