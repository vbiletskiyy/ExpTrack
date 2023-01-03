require 'rails_helper'

RSpec.describe Spendings::Operation::Delete do
  subject(:operation) { described_class }

  let(:spending) { create(:spending) }


  describe 'success' do
    it 'destroy spending' do
      op = operation.call(params: { id: spending.id })
      expect(Spending.exists?(id: spending.id)).to be false
      expect(op).to be_success
    end
  end
end
