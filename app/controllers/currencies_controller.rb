class CurrenciesController < ApplicationController
  before_action :currency, only: [:show]

  # GET /currencies
  def index
    @currencies = Currency.page(params[:page])
    json_response(@currencies)
  end

  # GET /currencies/:id
  def show
    json_response(@currency)
  end

  private

  def currency_params
    params.permit(:name, :rate)
  end

  def currency
    @currency = Currency.find(params[:id])
  end
end
