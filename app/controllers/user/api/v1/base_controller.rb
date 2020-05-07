class User::Api::V1::BaseController < ActionController::API

  def require_user!
    four_oh_four unless current_user && current_user.user?
  end

  def current_user
    @current_user ||= if session[:user_id]
                        User.find(session[:user_id])
                      else
                        User.new
                      end
  end
end
