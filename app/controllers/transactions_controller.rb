class TransactionsController < ApplicationController
  before_action :set_transaction, only: [ :show ]

  # include JSONAPI::Errors

  def index
    transactions = Current.user.transactions.ransack(params[:q] || {}).result.page(params[:page]).per(25)
    render jsonapi: transactions, status: :ok
  end

  def show
    render jsonapi: @transaction, status: :ok
  end

  def create
    @transaction = Current.user.transactions.new(transaction_params)

    if @transaction.save
      render jsonapi: @transaction, status: :created
    else
      render jsonapi_errors: @transaction.errors, status: :unprocessable_entity
    end
  end

  def balance
    render json: { balance: Current.user.balance }, status: :ok
  end

  private

  def set_transaction
    @transaction = Current.user.transactions.find_by(id: params[:id])
    unless @transaction
      render jsonapi_errors: { detail: "Transaction not found" }, status: :not_found
    end
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :transaction_type, :description)
  end
end
