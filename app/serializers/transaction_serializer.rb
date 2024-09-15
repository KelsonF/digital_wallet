class TransactionSerializer
  include JSONAPI::Serializer

  attributes :amount, :transaction_type, :description, :user_id, :created_at, :updated_at
  belongs_to :user
end
