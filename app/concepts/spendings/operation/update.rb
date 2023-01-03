module Spendings::Operation
  class Update < Trailblazer::Operation
    step Model(Spending, :find_by)
    step Contract::Build(constant: Spendings::Contract::Create)
    step Contract::Validate()
    step Contract::Persist()
  end
end
