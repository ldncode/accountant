class User < ApplicationRecord
  has_many :account, dependent: :destroy

  validates :email, :password, presence: true

end
