class User < ApplicationRecord
  has_secure_password
  has_many :transactions, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
end
