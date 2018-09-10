FactoryBot.define do
  factory :target_set do
    countries { ['hk'] }
    placements { ['desktop'] }
    gender { 0 }
    age_range { [11,20] }
  end
end
