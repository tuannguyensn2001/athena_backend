# frozen_string_literal: true

require 'rails_helper'

describe AuthService::Login do
  let(:secret_key) { 'secret' }
  let(:params) do
    {
      phone: '0984565910',
      password: 'java2001',
      role: 'teacher'
    }
  end

  let!(:user) { FactoryBot.create(:user, phone: params[:phone], role: params[:role]) }
  let(:service) { described_class.new(params, secret_key) }

  describe '#call' do
    context 'params valid' do
      it 'returns success' do
        result = service.call
        expect(service.success?).to eq(true)
        decoded = JWT.decode(result[:access_token], secret_key)
        expect(decoded[0]['data']['id']).to eq(user.id)
      end
    end
  end
end
