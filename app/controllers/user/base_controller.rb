class User::BaseController < ApplicationController
  # before_action :require_user!

  def current_user
    @current_user ||= if session[:user_id]
                        User.find(session[:user_id])
                      else
                        User.new
                      end
  end
end
