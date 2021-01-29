FactoryBot.define do
  factory :customer do
    name {Faker::Name.unique.first_name}
    surname {Faker::Name.unique.last_name}
  end
end