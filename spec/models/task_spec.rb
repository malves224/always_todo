require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(3) }
    it { should validate_length_of(:description).is_at_most(255) }
  end
end
