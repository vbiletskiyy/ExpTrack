require 'rails_helper'

RSpec.describe Auth::Operation::CreateAccount do
  subject(:operation) { described_class }

  let(:organization) { FactoryBot.create(:organization) }
  let(:user) { FactoryBot.create(:user) }
  let(:params) {
    {
      email: Faker::Internet.email,
      name: Faker::Internet.username,
      password: '1234qweasd',
      password_confirmation: '1234qweasd'
    }
  }

  describe 'success' do
    it 'create user' do
      op = operation.call(params: params)
      expect(User.exists?(id: op[:model].id)).to be true
      expect(op).to be_success
    end

    it 'encrypts the password' do
      op = operation.call(params: params)
      expect(op[:model][:password_digest].size).to eq(60)
      expect(op).to be_success
    end
  end

  describe 'failure' do
    it 'invalid email' do
      op = operation.call(params: params.merge(email: nil))
      expect(op[:error]).to eq('Email is invalid')
      expect(op).to be_failure
    end

    it 'invalid password and length' do
      op = operation.call(params: params.merge(password: nil))
      expect(op[:'result.contract.default'].errors.messages).to match(password: ["must be filled", "size cannot be less than 6"])
      expect(op).to be_failure
    end

    it 'invalid name' do
      op = operation.call(params: params.merge(name: nil))
      expect(op[:'result.contract.default'].errors.messages).to match(name: ['must be filled'])
      expect(op).to be_failure
    end
  end
end
