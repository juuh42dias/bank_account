FactoryBot.define do
  factory :account_transaction do
    account
    amount { Faker::Number.decimal(l_digits: 2) }

    trait :deposit do
      operation_type { AccountTransaction::TYPES['DEPOSIT'] }
    end

    trait :withdraw do
      operation_type { AccountTransaction::TYPES['WITHDRAW'] }
    end
  end
end
