require 'rails_helper'

RSpec.describe Auth::Operation::Login do
  subject(:operation) { described_class }

  let(:user) { FactoryBot.create(:user) }
  let(:params) {
    {
      email: user.email,
      password: '1234qweasd'
    }
  }

  describe 'failure' do
    it 'invalid email' do
      op = operation.call({params: {email: 'non@gmail.com', password: '123qweasd'}})
      expect(op[:error]).to eq('Email or password is incorrect')
      expect(op).to be_failure
    end

    it 'invalid password' do
      op = operation.call({params: {email: 'non@gmail.com', password: nil}})
      expect(op[:error]).to eq('Email or password is incorrect')
      expect(op).to be_failure
    end
  end
end
