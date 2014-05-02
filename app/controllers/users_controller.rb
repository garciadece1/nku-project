class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    params = user_params
    params['completed'] = true
    params['verified'] = false

    @user = User.new(params)

    if @user.save
      sign_in_user(@user)
      redirect_to files_path
    else
      render 'new'
    end
  end

  def show
  end

  def update
  end

  def modify
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
