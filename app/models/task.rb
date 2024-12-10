class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { minimum: 3 }
  validates :description, length: { maximum: 255 }, allow_blank: true

  enum status: { pending: 'pending', done: 'done' }
  validates :status, inclusion: { in: statuses.keys }
  default_scope do
    raise 'Current.user is not set' unless Current.user

    where(user_id: Current.user)
  end
end
