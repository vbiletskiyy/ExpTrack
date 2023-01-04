require 'rails_helper'

RSpec.describe Spendings::Operation::Create do
  subject(:operation) { described_class }

  let(:current_user) { create(:user) }
  let(:spending_category) { create(:spending_category) }
  let(:params) {
    {
      amount: 24,
      description: 'description',
      spending_category_id: spending_category.id
    }
  }

  describe 'success' do
    it 'create spending' do
      op = operation.call(current_user: current_user, params: params)
      expect(Spending.exists?(amount: params[:amount], description: params[:description], spending_category_id: spending_category.id)).to be true
      expect(op).to be_success
    end
  end

  describe 'failure' do
    it 'invalid amount' do
      op = operation.call(current_user: current_user, params: params.merge(amount: 'a'))
      expect(op[:'contract.default'].errors.messages).to eq({amount: ['must be an integer']})
      expect(op).to be_failure
    end
    
    it 'invalid description' do
      op = operation.call(current_user: current_user, params: params.merge(description: nil))
      expect(op[:'contract.default'].errors.messages).to eq({description: ['must be filled']})
      expect(op).to be_failure
    end

    it 'invalid spending category id' do
      op = operation.call(current_user: current_user, params: params.merge(spending_category_id: nil))
      expect(op[:'contract.default'].errors.messages).to eq({spending_category_id: ['must be filled']})
      expect(op).to be_failure
    end
  end
end
