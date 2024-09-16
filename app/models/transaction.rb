class Transaction < ApplicationRecord
  belongs_to :user

  # Enum para tipos de transações
  enum :transaction_type, { :deposit=> 0, :withdrawal=> 1 } # rubocop:disable Style/HashSyntax

  # Validações
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :transaction_type, presence: true

  # Se você quiser validar a descrição opcional, adicione:
  validates :description, length: { maximum: 255 }
end
