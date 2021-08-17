class SessionsController < ApplicationController
  
  before_action :auto_login, unless: :logged_in?
  
  def new
  end

  def create
    @user = User.find_by(email: session_params[:email]&.downcase)
    if @user&.authenticate(session_params[:password])
      log_in @user
      session_params[:remember_me] == "1" ? remember(@user) : forget(@user)
      redirect_back_or(@user)
    else
      flash.now[:danger] = "正しくないメールアドレス/パスワードが入力されています。"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
  

  private
    def session_params
      params.require(:session).permit(:email, :password, :remember_me)
    end

    # 永続セッションを保持している場合、ログインする
    # before_action
    def auto_login
      if (user_id = cookies.signed[:user_id])
        user = User.find_by(id: user_id)
        if user&.authenticate?(cookies[:remember_token])
          log_in user
          @current_user = user
          redirect_to user
        else
          redirect_to login_path
        end
      end
    end
end
