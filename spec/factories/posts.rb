FactoryBot.define do
  factory :post do
    association :user
    title 'New Post Title'
  end
end
