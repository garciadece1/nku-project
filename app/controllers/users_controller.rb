class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    params = user_params
    params['completed'] = true
    params['verified'] = false

    current_user = User.find_by_email(params['email'])

    if (current_user.nil?)
      current_user = User.new(params)
      if current_user.save
        sign_in_user(current_user)
        redirect_to files_path
      else
        render 'new'
      end
    else
      if current_user.update(params)
        sign_in_user(current_user)
        redirect_to files_path
      else
        render 'new'
      end
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
