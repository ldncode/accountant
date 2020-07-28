class Expense < ApplicationRecord
  belongs_to :account

  validates :title, :value,  presence: true
end
