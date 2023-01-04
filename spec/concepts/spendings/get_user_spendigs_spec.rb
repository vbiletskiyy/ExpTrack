require 'rails_helper'

RSpec.describe Spendings::Operation::GetUserSpendings do
  subject(:operation) { described_class }

  let(:user) { create(:user) }
  let(:user_spending) { create(:user_spending, sent_by: user.id) }


  describe 'success' do
    it 'destroy spending' do
      current_user = User.find_by(id: user_spending.user_id)
      op = operation.call(current_user: current_user, user_id: user.id)
      expect(op).to be_success
    end
  end
end
