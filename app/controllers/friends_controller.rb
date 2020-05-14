class FriendsController < ApplicationController

  def create
    friend = User.find_by(uid: friends_param[:id])
    if friend
      friendship = current_user.friendships.build(friend_id: friend.id)
      friendship.save ? success : error
    else
      error
    end
    redirect_to dashboard_path
  end

  private

  def friends_param
    params.permit(:id)
  end

  def success
    flash[:success] = 'Added friend.'
  end

  def error
    flash[:error] = 'Unable to add friend.'
  end
end
