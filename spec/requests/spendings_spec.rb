# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Spendings', type: :request do
  it 'should generate correct routes' do
    assert_routing({ path: 'spendings', method: :post },
                   { controller: 'spendings', action: 'create' })
    assert_routing({ path: 'spendings', method: :get },
                   { controller: 'spendings', action: 'index' })
    assert_routing({ path: 'spendings/new', method: :get },
                   { controller: 'spendings', action: 'new' })
    assert_routing({ path: 'spendings/1', method: :patch },
                   { controller: 'spendings', action: 'update', id: '1' })
    assert_routing({ path: 'spendings/1', method: :put },
                   { controller: 'spendings', action: 'update', id: '1' })
    assert_routing({ path: 'spendings/1', method: :delete },
                   { controller: 'spendings', action: 'destroy', id: '1' })
    assert_routing({ path: 'spendings/1/edit', method: :get },
                   { controller: 'spendings', action: 'edit', id: '1' })
    assert_routing({ path: 'page/some-uuid', method: :get },
                   { controller: 'spendings', action: 'page', uuid: 'some-uuid' })
  end

  let(:user) { create(:user) }
  let(:spendings) { create_list(:spending, 2, user: user) }

  before(:each) { sign_in(user) }

  describe 'GET /page/:uuid' do
    context 'with valid uuid' do
      let(:encrypted_uuid) do
        crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base[0..31])
        crypt.encrypt_and_sign({user_id: user.id, filter: :amount}.to_json)
      end
      it "should render a page with user's spendings" do
        get page_url(uuid: encrypted_uuid)
        expect(response).to have_http_status :ok
        expect(response).to render_template :page
      end
    end
    context 'with invalid uuid' do
      it 'should return 404.html' do
        get page_url(uuid: 'not valid uuid')
        expect(response).to have_http_status :not_found
      end
    end
  end
  describe 'GET /index' do
    before(:each) do
      user
      spendings
      get spendings_url
    end

    it 'should render the correct template' do
      expect(response).to have_http_status :ok
      expect(response).to render_template :index
    end
    it 'should display all spendings' do
      spendings.each do |spending|
        expect(response.body).to include(ERB::Util.html_escape(spending.name))
        expect(response.body).to include(spending.amount.to_s)
        expect(response.body).to include(spending.category)
      end
    end
  end

  let(:spending) { build(:spending, user: user) }
  let(:invalid_spending) { build(:spending, user: user, amount: -4) }
  describe 'POST /index' do
    context 'with valid attributes' do
      it 'should save a spending' do
        expect do
          post spendings_path, params:
            { spending: JSON.parse(spending.to_json) }
        end.to change { Spending.count }.by(1)
      end
    end
    context 'with invalid attributes' do
      context 'with negative amount' do
        it 'should NOT save a spending' do
          expect do
            post spendings_path, params:
              { spending: JSON.parse(invalid_spending.to_json) }
          end.to change { Spending.count }.by(0)
        end
      end
    end
  end

  describe 'PUT /spendings/:id' do
    context 'with valid parameters' do
      it 'should update a spending' do
        put spending_path(spendings[0]), params:
          { spending: JSON.parse(spending.to_json) }
        expect(spendings[0].reload.name).to eq(spending.name)
        expect(spendings[0].amount).to eq(spending.amount)
        expect(spendings[0].category).to eq(spending.category)
      end
    end
    context 'with invalid params' do
      it 'should update a spending' do
        put spending_path(spendings[0]), params:
          { spending: JSON.parse(invalid_spending.to_json) }
        expect(spendings[0].reload.name).to_not eq(spending.name)
        end
    end
  end

  let(:new_spending) { create(:spending, user: user)}
  describe 'DELETE /spending/:id' do
    it 'should delete a spending' do
      new_spending
      expect { delete spending_path(new_spending.id) }
        .to change { Spending.count }.by(-1)
    end
  end
end
