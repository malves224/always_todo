require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should have_secure_password }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value('email@example.com').for(:email) }
    it { should_not allow_value('email').for(:email) }

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }

    it { should validate_presence_of(:name) }

    it 'validates presence of password confirmation if password required' do
      user = build(:user, password: 'password', password_confirmation: nil)
      user.password_required?
      expect(user).to validate_presence_of(:password_confirmation)
    end

    it 'validates confirmation of password' do
      user = build(:user)
      expect(user).to be_valid
    end

    context 'with email invalid' do
      it 'is invalid' do
        user = build(:user, email: 'email')
        expect(user).to_not be_valid
      end
    end

    context 'with email valid' do
      it 'is valid' do
        user = create(:user, email: 'matheus@gmail.com')
        expect(user).to be_valid
      end
    end
  end
end
