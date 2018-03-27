FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@email.com"}
    name "Testy Dude"
    password "Test!"
  end
end
