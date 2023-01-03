require 'rails_helper'

RSpec.describe Spendings::Operation::SendSpending do
  subject(:operation) { described_class }

  let(:current_user) { create(:user) }
  let(:user) { create(:user) }
  let(:spending) { create(:spending) }

  describe 'success' do
    it 'send spendings to user' do
      current_user.spendings << spending
      op = operation.call(current_user: current_user, user_ids: [user.id])
      expect(op).to be_success
      expect(UserSpending.exists?(sent_by: current_user.id, user_id: user.id, sent: true)).to be true
    end
  end
end
