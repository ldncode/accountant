class Account < ApplicationRecord
  belongs_to :user
  has_many :expenses, dependent: :destroy

  validates :nickname, presence: true
end
