class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, ]
  def index
    @users= User.all.page(params[:page])
  end

  def show
    @user= User.find(params[:id])
  end

  def new
    @users= User.new
  end

  def create
      @users = User.new(user_params)

    if @users.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @users
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end


 private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end