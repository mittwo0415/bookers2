class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  def new
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])  
    @books = @user.books   
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(current_user)  
    else
      render :edit
    end
  end
  
  def get_profile_image(width, height)
    # プロフィール画像のパスを組み立てる
    profile_image_path = "/path/to/profile_images/#{self.profile_image_filename}"
    # プロフィール画像のURLを組み立てる
    profile_image_url = "http://example.com#{profile_image_path}"
    return profile_image_url
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :introduction)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end 
end
