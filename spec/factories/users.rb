FactoryBot.define do
  factory :user do
    # email { Faker::Internet.email }
    # password { Faker::Internet.password(min_length: 6) }
    email { 'user@mail.com' }
    password { 'usermail' }
  end
end
