# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'with valid attributes' do
    it 'should be valid' do
      expect(create(:user)).to be_valid
    end
  end

  context 'with invalid attributes' do
    context 'with invalid email' do
      it 'should be invalid' do
        expect(build(:user, email: nil)).to_not be_valid
      end
    end

    context 'with invalid password' do
      it 'should be invalid' do
        expect(build(:user, password: nil)).to_not be_valid
      end
    end

    context 'with invalid password' do
      it 'should be invalid' do
        expect(build(:user, username: nil)).to_not be_valid
      end
    end
  end
end