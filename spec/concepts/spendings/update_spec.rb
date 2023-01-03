require 'rails_helper'

RSpec.describe Spendings::Operation::Update do
  subject(:operation) { described_class }

  let(:spending_category) { create(:spending_category) }
  let(:spending) { create(:spending) }
  let(:params) {
    {
      amount: 24,
      description: 'description',
      spending_category_id: spending_category.id
    }
  }

  describe 'success' do
    it 'update spending' do
      op = operation.call(params: params.merge(id: spending.id))
      expect(op[:model].amount).to eq(params[:amount])
      expect(op).to be_success
    end
  end

  describe 'failure' do
    it 'invalid amount' do
      op = operation.call(params: params.merge(amount: 'a', id: spending.id))
      expect(op[:'contract.default'].errors.messages).to eq({amount: ['must be an integer']})
    end
    
    it 'invalid description' do
      op = operation.call(params: params.merge(description: nil, id: spending.id))
      expect(op[:'contract.default'].errors.messages).to eq({description: ['must be filled']})
    end

    it 'invalid spending category id' do
      op = operation.call(params: params.merge(spending_category_id: nil, id: spending.id))
      expect(op[:'contract.default'].errors.messages).to eq({spending_category_id: ['must be filled']})
    end
  end
end
