class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    videos = YouTube::Video.by_playlist(playlist_params[:playlist_id])
    tutorial_info = YouTube::Playlist.info(playlist_params[:playlist_id])
    if tutorial_info && videos
      tutorial = Tutorial.create(tutorial_info_params(tutorial_info))
      add_videos_to_tutorial(tutorial, videos)
    else
      flash[:error] = 'Unable to create tutorial.'
    end
    redirect_to admin_dashboard_path
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

  def playlist_params
    params.require(:tutorial).permit(:playlist_id)
  end

  def tutorial_info_params(tutorial)
    { title: tutorial.title,
      description: tutorial.description,
      thumbnail: tutorial.thumbnail,
      playlist_id: tutorial.id }
  end

  def video_params(video)
    { title: video.title,
      description: video.description,
      thumbnail: video.thumbnail,
      video_id: video.id }
  end

  def add_videos_to_tutorial(tutorial, videos)
    videos.each_with_index do |video, position|
      video = tutorial.videos.new(video_params(video).merge(position: position))
      if video.save
        link = view_context.link_to('View it here', tutorial_path(tutorial))
        flash[:success] = "Successfully created tutorial. #{link}."
      end
    end
  end
end
