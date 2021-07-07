FactoryBot.define do
  factory :doorlock do
    state { 'open' }
    created_at { Time.now }
  end
end
