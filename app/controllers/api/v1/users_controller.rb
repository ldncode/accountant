class Api::V1::UsersController < Api::V1::BaseController


  def index
    @users = User.all
    json_response(@users)
  end

  def create
    @user = User.create!(user_params)
    json_response(@user, :created)
  end

  private

  def user_params
    params.permit(:email, :password)
  end

end
