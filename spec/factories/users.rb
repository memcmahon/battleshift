FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@email.com"}
    sequence(:name) { |n| "Testy #{n}" }
    password "Test!"
  end
end
