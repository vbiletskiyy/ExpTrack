require "reform/form/dry"

module Auth::Contract
  class CreateAccount < Reform::Form
    feature Reform::Form::Dry

    property :name
    property :email
    property :password
  
    validation do
      params do
        required(:name).filled(:string)
        required(:password).filled(:string, min_size?: 6)
        required(:email).filled(:string)
      end
    end
  end
end
