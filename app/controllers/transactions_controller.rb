class TransactionsController < ApplicationController
  before_action :set_transaction, only: [ :show, :update, :destroy ]

  include JSONAPI::Errors

  def index
    transactions = Current.user.transactions.ransack(params[:q]).result.page(params[:page]).per(25)
    render jsonapi: transactions, status: :ok
  end

  def show
    render jsonapi: @transaction
  end

  def create
    @transaction = Current.user.transactions.new(transaction_params)

    if @transaction.save
      render jsonapi: @transaction, status: :created
    else
      render jsonapi_errors: @transaction.errors, message: :unprocessable_entity
    end
  end

  def balance
    balance = Current.user.balance
    render jsonapi: balance
  end

  private

  def set_transaction
    @transaction = Current.user.transactions.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :transaction_type, :description)
  end
end
