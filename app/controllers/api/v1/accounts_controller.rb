class Api::V1::AccountsController < Api::V1::BaseController
  before_action :user_find

  def index
    @accounts = @user.accounts.all
    json_response(@accounts)
  end

  private

  def user_find
    @user = User.find(params[:user_id])
  end
end
