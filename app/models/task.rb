class Task < ApplicationRecord
  belongs_to :user
  belongs_to :category, dependent: :destroy

  validates :category_id, presence: true
end