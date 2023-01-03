class SpendingsController < ApplicationController
  before_action :user_authenticated?
  before_action :set_spending, only: %i[ show edit update destroy ]
  before_action :set_categories

  def index
    @users = User.all.where.not(id: current_user.id)
    @result = Spendings::Operation::Index.(filter: params[:filter], current_user: current_user)
    @pagy, @spendings = pagy(@result[:filtered])
  end

  def new
    @spending = Spending.new
  end

  def edit
  end

  def create
  @spending = Spending.new(spending_params)
    if @spending.save
      current_user.spendings << @spending
      redirect_to spendings_url, notice: "Spending was successfully created."
    else
      render turbo_stream: turbo_stream.update("remote_modal_body", partial: "form_update")
    end
  end

  def update
    if @spending.update(spending_params)
      redirect_to spendings_url, notice: "Spending was successfully updated."
    else
      render turbo_stream: turbo_stream.update("remote_modal_body", partial: "form_update")
    end
  end

  def destroy
    @spending.destroy
    redirect_to spendings_url, notice: "Spending was successfully destroyed."
  end

  def send_spendings
    result = Spendings::Operation::SendSpending.(user_ids: params[:user_ids], current_user: current_user)
    redirect_to spendings_url, notice: "Your spendings have been successfully submitted"
  end

  def users_list
    @user_ids = UserSpending.where(user_id: current_user.id, sent: true).pluck(:sent_by)
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
    params.require(:spending).permit(:description, :amount, :spending_category_id)
  end
end
