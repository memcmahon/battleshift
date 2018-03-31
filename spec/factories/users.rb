FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@email.com"}
    sequence(:name) { |n| "Testy #{n}" }
    activated true
    password "Test!"
  end
end
