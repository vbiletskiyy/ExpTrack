require 'rails_helper'

RSpec.describe Spendings::Operation::Index do
  subject(:operation) { described_class }

  let(:current_user) { create(:user) }
  let!(:user_spending) { create_list(:user_spending, 10, user_id: current_user.id) }


  describe 'success' do
    it 'destroy spending' do
      op = operation.call(current_user: current_user, filter: "")
      expect(op[:user_spendings].size).to eq(10)
      expect(op).to be_success
    end
  end
end
