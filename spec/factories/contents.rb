FactoryBot.define do
  factory :content do
    user { FactoryBot.create(:user, email: "mark@gmail.com") }
    title { "New content" }
    body { "New Content Body" }
  end
end
