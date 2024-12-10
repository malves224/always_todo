class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { minimum: 3 }
  validates :description, length: { maximum: 255 }, allow_blank: true

  enum status: { pending: 'pending', done: 'done' }
  validates :status, inclusion: { in: statuses.keys }
end
