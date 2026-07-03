FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name { "Von" }
    email { "johnvon@gmail.com" }
    password { "verysecret" }
    country { "US" }
  end
end
