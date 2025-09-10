FactoryBot.define do
  factory :session do
    user
    user_agent { "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)" }
    ip_address { "127.0.0.1" }

    trait :masquerading do
      association :admin_user, factory: :user
      masquerade_at { Time.current }
    end
  end
end