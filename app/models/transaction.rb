class Transaction < ApplicationRecord
  belongs_to :user

  # Enum para tipos de transações
  enum :transaction_type, { :deposit=> 0, :withdrawal=> 1 } # rubocop:disable Style/HashSyntax

  # Validações
  validate :sufficient_balance_for_withdrawal, if: :withdrawal?
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :transaction_type, presence: true
  validates :description, length: { maximum: 255 }

  private

  def sufficient_balance_for_withdrawal
    if amount > user.balance
      errors.add(:amount, "Insufficient balance for this transaction")
    end
  end
end
