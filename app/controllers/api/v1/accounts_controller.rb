class Api::V1::AccountsController < Api::V1::BaseController
  before_action :user_find
  before_action :set_user_account, only: [:show, :update]

  def index
    json_response(@user.accounts)
  end

  def show
    json_response(@account)
  end

  def create
    @account = @user.accounts.create!(account_params)
    json_response(@account, :created)
  end

  def update
    @account.update(account_params)
    head :no_content
  end

  private

  def user_find
    @user = User.find(params[:user_id])
  end

  def account_params
    params.permit(:nickname)
  end

  def set_user_account
    @account = @user.accounts.find_by!(id: params[:id]) if @user
  end
end
