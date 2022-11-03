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
  end

  let(:user) { create(:user) }
  let(:spendings) { create_list(:spending, 2, user: user) }

  before(:each) { sign_in(user) }

  describe 'GET /index' do
    before(:each) { get spendings_url }
    it 'should render the correct template' do
      expect(response).to have_http_status :ok
      expect(response).to render_template :index
    end
    it 'should display all spendings' do
      spendings.each do |spending|
        expect(response.body).to include(spending.name)
        expect(response.body).to include(spending.amount)
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
      expect { delete spending_path(new_spending.id) }
        .to change { Spending.count }.by(-1)
    end
  end
end
