module Auth::Operation
  class Login < Trailblazer::Operation
    step :find_user
    step :password_hash_match?
    fail ->(ctx, **) { ctx['error'] = 'Email or password is incorrect' }, fail_fast: true

    def find_user(ctx, params:, **)
      ctx[:user] = User.find_by(email: params[:email])
    end

    def password_hash_match?(ctx, user:, params:, **)
      BCrypt::Password.new(user.password_digest) == params[:password]
    end
  end
end
