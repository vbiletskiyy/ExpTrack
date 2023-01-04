module Spendings::Operation
  class Delete < Trailblazer::Operation
    step Model(Spending, :find_by)
    step :destroy

    def destroy(ctx, model:, current_user:, **)
      model.destroy
      UserSpending.where(user_id: current_user.id, spending_id: model.id).destroy_all
    end
  end
end
