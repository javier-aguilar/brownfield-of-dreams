class UserVideosController < ApplicationController
  def new; end

  def create
    current_user ? add_bookmark : redirect_to_login
  end

  private

  def user_video_params
    params.permit(:user_id, :video_id)
  end

  def add_bookmark
    user_video = UserVideo.new(user_video_params)
    if current_user.user_videos.find_by(video_id: user_video.video_id)
      flash[:error] = 'Already in your bookmarks'
    elsif user_video.save
      flash[:success] = 'Bookmark added to your dashboard!'
    end
    redirect_back(fallback_location: root_path)
  end

  def redirect_to_login
    flash[:error] = 'Please login to save bookmark'
    redirect_to login_path
  end
end
