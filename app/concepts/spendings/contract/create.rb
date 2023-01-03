require "reform/form/dry"

module Spendings::Contract
  class Create < Reform::Form
    feature Reform::Form::Dry

    property :amount
    property :description
    property :spending_category_id
  
    validation do
      params do
        required(:amount).filled(:integer)
        required(:description).filled(:string)
        required(:spending_category_id).filled(:integer)
      end
    end
  end
end
