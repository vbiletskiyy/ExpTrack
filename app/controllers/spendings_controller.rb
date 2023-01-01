class SpendingsController < ApplicationController
  before_action :set_spending, only: %i[ show edit update destroy ]
  before_action :set_categories

  def index
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

  private

  def set_categories
    @categories = SpendingCategory.all
  end

  def set_spending
    @spending = Spending.find(params[:id])
  end

  def spending_params
    params.require(:spending).permit(:description, :amount, :spending_category_id).merge!(user_id: current_user.id)
  end
end
