FactoryBot.define do
  factory :team do
    name { "Team #{rand(1000..9999)}" }
  end
end