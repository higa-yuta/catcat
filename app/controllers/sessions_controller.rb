class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: session_params[:email]&.downcase)
    if user&.authenticate(session_params[:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = "正しくないメールアドレス/パスワードが入力されています。"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
