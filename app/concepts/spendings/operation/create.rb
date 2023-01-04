module Spendings::Operation
  class Create < Trailblazer::Operation
    step Model(Spending, :new)
    step Contract::Build(constant: Spendings::Contract::Create)
    step Contract::Validate()
    step Contract::Persist()
    step :attach_spending

    def attach_spending(ctx, current_user:, model:, **)
      current_user.spendings << model
    end
  end
end
