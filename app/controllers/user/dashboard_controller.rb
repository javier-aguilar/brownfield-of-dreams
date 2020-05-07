class User::DashboardController < User::BaseController
  def show
    @facade = UserDashboardFacade.new
  end
end
