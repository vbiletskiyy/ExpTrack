module Spendings::Operation
  class GetUserSpendings < Trailblazer::Operation
    step :get_shared_spendings

    def get_shared_spendings(ctx, current_user:, user_id:, **)
      ctx[:spendings] = Spending.includes(:user_spendings).where(user_spendings: { sent_by: user_id, user_id: current_user.id, sent: true })
    end
  end
end
