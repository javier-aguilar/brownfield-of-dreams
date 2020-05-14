class Admin::VideosController < Admin::BaseController
  def edit
    @video = Video.find(params[:id])
  end

  def update
    video = Video.find(params[:id])
    if video_params[:position]
      video.update(video_params)
    else
      video.update(new_video_params)
      redirect_to root_path
    end
  end

  def create
    tutorial = Tutorial.find(params[:tutorial_id])
    thumbnail = YouTube::Video.by_id(new_video_params[:video_id]).thumbnail
    video = tutorial.videos.new(new_video_params.merge(thumbnail: thumbnail))
    flash[:success] = 'Successfully created video.' if video.save
    redirect_to edit_admin_tutorial_path(id: tutorial.id)
  end

  private

  def video_params
    params.permit(:position)
  end

  def new_video_params
    params.require(:video).permit(:title, :description, :video_id, :thumbnail)
  end
end
