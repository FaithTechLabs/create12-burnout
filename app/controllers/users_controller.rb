class UsersController < ApplicationController
  def new
    @user= User.new
  end
  def create
    @user= User.new(user_params)
  end
  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :accountability_email,
      :is_married,
      :has_children,
      :birthday,
      :church_size
    )
  end
end
