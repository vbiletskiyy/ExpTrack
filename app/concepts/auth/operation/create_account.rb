module Auth::Operation
  class CreateAccount < Trailblazer::Operation
    step Model(User, :new)
    step Contract::Build(constant: Auth::Contract::CreateAccount)
    step Contract::Validate()
    step :check_email
    fail ->(ctx, **) { ctx['error'] = 'Email is invalid' }, fail_fast: true
    step :passwords_identical?
    fail ->(ctx, **) { ctx['error'] = 'Passwords do not match' }, fail_fast: true
    step Contract::Persist()

    def check_email(ctx, params:, **)
      params[:email] =~ /\A[^,;@ \r\n]+@[^,@; \r\n]+\.[^,@; \r\n]+\z/
    end
    
    def passwords_identical?(ctx, params:, **)
      params[:password] == params[:password_confirmation]
    end

    def save_account(ctx, email:, password:, name:, **)
      user = User.create(email: email, password: password, name: name)
      ctx[:user] = user
    end
  end
end
