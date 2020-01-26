class Currency < ApplicationRecord
  validates :name, uniqueness: true
  validates :name, :rate, presence: true
end
