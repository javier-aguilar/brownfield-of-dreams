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
    items = data[:items]
    return unless data[:nextPageToken]

    params = params.merge(pageToken: data[:nextPageToken])
    more_item_results(params, items)
  end

  private

  def more_item_results(params, items)
    next_page_results = get_json('youtube/v3/playlistItems', params)
    items += next_page_results[:items]
    while next_page_results[:nextPageToken]
      params[:pageToken] = next_page_results[:nextPageToken]
      next_page_results = get_json('youtube/v3/playlistItems', params)
      items += next_page_results[:items]
    end
    items
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
