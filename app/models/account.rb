class Account < ApplicationRecord
  belongs_to :user
  has_many :expense, dependent: :destroy

  validates :nickname, presence: true
end
