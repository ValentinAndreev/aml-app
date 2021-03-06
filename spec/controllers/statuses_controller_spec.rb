require 'rails_helper'

RSpec.describe Amlapp::StatusesController, type: :controller do
  describe '#base actions' do
    let(:administrator) { create(:aml_operator, role: 'administrator') }
    let(:aml_status) { create(:aml_status) }

    before { login_user(administrator) }

    context 'with registered administrator' do
      it '#create' do
        post :create, params: { aml_status: attributes_for(:aml_status) }
        expect(response).to be_successful
      end

      it '#index' do
        get :index
        expect(response).to be_successful
      end

      it '#show' do
        get :show, params: { id: aml_status.id }
        expect(response).to be_successful
      end
    end
  end
end
