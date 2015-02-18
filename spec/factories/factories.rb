FactoryGirl.define do
  sequence(:email)      { |n| "email-#{n}@example.com" }
  sequence(:first_name) { |n| "FirstName#{n}" }
  sequence(:last_name)  { |n| "LastName#{n}" }

  factory :user do
    first_name
    last_name
    email
    confirmed_at { Time.now }
    password "password"
    approved true

    trait :unconfirmed do
      confirmed_at nil
    end

    trait :unapproved do
      approved false
    end
  end
end
