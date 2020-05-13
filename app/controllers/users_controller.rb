class UsersController < ApplicationController
  def show
    @user = UserFacade.new(current_user) if current_user.token
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      UserActivationMailer.registration_confirmation(@user).deliver
      flash[:success] = "This account has not yet been activated. Please check your email."
      redirect_to dashboard_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Welcome to the Brownfield"
      redirect_to login_path
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to :root
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def confirmation_token
    if self.confirm_token.blank?
        self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
