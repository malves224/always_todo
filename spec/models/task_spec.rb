require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should validate_presence_of(:title) }
  end
end
