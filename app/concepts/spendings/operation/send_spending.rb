module Spendings::Operation
  class SendSpending < Trailblazer::Operation
    step :send_spendings

    def send_spendings(ctx, user_ids:, current_user:, **)
      spending_ids = current_user.spendings.pluck(:id)
      user_ids.compact_blank.each do |user_id|
        spending_ids.each do |spending_id|
          UserSpending.find_or_create_by(sent: true, sent_by: current_user.id, user_id: user_id, spending_id: spending_id)
        end
      end
    end
  end
end
