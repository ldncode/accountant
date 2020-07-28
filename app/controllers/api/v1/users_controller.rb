class Api::V1::UsersController < Api::V1::BaseController
  before_action :user_find, only: [:show, :destroy]

  def index
    @users = User.all
    json_response(@users)
  end

  def show
    json_response(@user)
  end

  def create
    @user = User.create!(user_params)
    json_response(@user, :created)
  end

  def destroy
    @user.destroy
  end

  private

  def user_params
    params.permit(:email, :password)
  end

  def user_find
    @user = User.find(params[:id])
  end

end
