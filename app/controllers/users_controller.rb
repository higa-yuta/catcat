class UsersController < ApplicationController

  before_action :logged_in_user?, only: [:show, :edit, :update, :destroy]
  before_action :correct_user,    only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to user_path(@user)
      flash[:success] = "登録することができました"
    else
      render "new"
    end
  end

  def show;  end

  def edit;  end

  def update
    if @user.update(user_params)
      flash[:success] = "更新することができました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "ユーザー情報を削除しました"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  
  private
    def user_params
      params.require(:user).permit( :name, :email, :password,
                                    :password_confirmation)
    end

    # ログイン済みかを確認
    def logged_in_user?
      unless logged_in?
        flash[:danger] = "ログインしてください"
        redirect_to login_path
      end
    end

    #　正しいユーザーの確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless @user == current_user
    end
end
