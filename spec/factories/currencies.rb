FactoryBot.define do
  factory :currency do
    name { Faker::Currency.name }
    rate { 42.3475 }
  end
end
