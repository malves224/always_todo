FactoryBot.define do
  factory :task do
    association :user
    title { Faker::Lorem.sentence }
    status { 'done' }
  end
end
