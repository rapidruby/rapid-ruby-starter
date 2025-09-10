FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name { "Doe" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "Password123!" }
    password_confirmation { "Password123!" }
    verified { false }
    admin { false }
    team

    trait :verified do
      verified { true }
    end

    trait :admin do
      admin { true }
    end
  end
end