class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Thanks for signing up."
      redirect_to @user
    else
      flash.now[:danger] = "Please fix the errors below."
      render 'new'
    end
  end

  private

    # User parameters.
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end