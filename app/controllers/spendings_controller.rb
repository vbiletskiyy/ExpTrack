class SpendingsController < ApplicationController
  before_action :user_authenticated?
  before_action :set_spending, only: %i[ show edit update destroy ]
  before_action :set_categories

  def index
    @users = User.all.where.not(id: current_user.id)
    @result = Spendings::Operation::Index.(filter: params[:filter], current_user: current_user)
    @pagy, @spendings = pagy(@result[:user_spendings])
  end

  def new
    @spending = Spending.new
  end

  def edit
  end

  def create
    result = Spendings::Operation::Create.(params: spending_params, current_user: current_user)
    render_result(result: result, path: spendings_url, notice: "Spending has been successfully created")
  end

  def update
    result = Spendings::Operation::Update.(params: spending_params)
    render_result(result: result, path: spendings_url, notice: "Spending has been successfully updated")
  end

  def destroy
    result = Spendings::Operation::Delete.(params: {id: params[:id]}, current_user: current_user)
    render_result(result: result, path: spendings_url, notice: "Spending has been successfully destroyed")
  end

  def send_spendings
    result = Spendings::Operation::SendSpending.(user_ids: params[:user_ids], current_user: current_user)
    redirect_to spendings_url, notice: "Your spendings have been successfully submitted"
  end

  def users_list
    @user_ids = UserSpending.where(user_id: current_user.id, sent: true).pluck(:sent_by).uniq
  end

  def user_spendings
    @result = Spendings::Operation::GetUserSpendings.(user_id: params[:user_id], current_user: current_user)
    @pagy, @spendings = pagy(@result[:spendings])
  end

  private

  def set_categories
    @categories = SpendingCategory.all
  end

  def set_spending
    @spending = Spending.find(params[:id])
  end

  def spending_params
    params.require(:spending).permit(:description, :amount, :spending_category_id).merge(id: params[:id])
  end
end
