module Spendings::Operation
  class Delete < Trailblazer::Operation
    step Model(Spending, :find_by)
    step :destroy

    def destroy(ctx, model:, **)
      model.destroy
    end
  end
end
