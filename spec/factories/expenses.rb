FactoryBot.define do
  factory :expense do
    title { "MyString" }
    value { 1 }
    account { nil }
  end
end
