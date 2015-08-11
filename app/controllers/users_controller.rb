class UsersController < ApplicationController
	before_action :signed_in_user, only: [:show, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
    	sign_in @user
      redirect_to home2_path
    else
      render 'new'
    end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Perfil actualizado"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :last_name, :email, :password,
                                   :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(home2_path) unless current_user?(@user)
    end
end
