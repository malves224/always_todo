class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true

  enum status: { pending: 'pending', done: 'done' }
  validates :status, inclusion: { in: statuses.keys }
end
