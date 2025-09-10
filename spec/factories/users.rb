FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name { "Doe" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "Secret1*3*5*" }
    password_confirmation { "Secret1*3*5*" }
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
