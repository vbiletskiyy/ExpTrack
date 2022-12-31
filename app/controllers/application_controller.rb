class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    User.find_by(id: session[:user_id])
  end

  def user_authenticated?
    redirect_to login_users_path if current_user.nil?
  end

  def render_result(result:, path:, notice: nil)
    if result.success?
      redirect_to path, notice: notice
    else
      @errors = result[:"contract.default"]&.errors&.messages.presence || result[:error]
      render turbo_stream: turbo_stream.update("validation_messages", partial: "shared/errors")
    end
  end
end
