class CurrencySerializer < ActiveModel::Serializer
  attributes :created_at, :id, :name, :rate, :updated_at
end
