class Expense < ApplicationRecord
  belongs_to :account

  validates :title, presence: true
end
