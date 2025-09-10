FactoryBot.define do
  factory :team_user do
    team
    user
    role { "owner" }

    trait :admin do
      role { "admin" }
    end

    trait :member do
      role { "member" }
    end
  end
end