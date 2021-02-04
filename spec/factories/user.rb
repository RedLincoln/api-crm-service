FactoryBot.define do
  factory :user do
    username {Faker::Internet.unique.username}
    email { Faker::Internet.unique.email}
    password {Faker::Internet.password(min_length: 8, max_length: 20)}
    role
  end
end