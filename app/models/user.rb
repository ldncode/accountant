class User < ApplicationRecord
  has_many :accounts, dependent: :destroy

  validates :email, :password, presence: true

end
