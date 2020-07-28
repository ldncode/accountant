class Api::V1::ExpensesController < Api::V1::BaseController
  before_action :user_find
  before_action :account_find

  def create
    @expense = @account.expenses.create!(expense_params)
    json_response(@expense, :created)
  end

  private

  def expense_params
    params.permit(:title, :value)
  end

  def user_find
    @user = User.find(params[:user_id])
  end

  def account_find
    @account = @user.accounts.find(params[:account_id])
  end
end
