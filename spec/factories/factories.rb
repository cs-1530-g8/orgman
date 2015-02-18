FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "FirstName#{n}" }
    sequence(:last_name)  { |n| "LastName#{n}" }
    sequence(:email)      { |n| "email-#{n}@example.com" }
    confirmed_at { Time.now }
    password 'password'
    approved true

    trait :unconfirmed do
      confirmed_at nil
    end

    trait :unapproved do
      approved false
    end
  end

  factory :link do
    sequence(:name)      { |n| "link#{n}" }
    url 'example.com'
    expiration { DateTime.tomorrow }
    user

    trait :expired do
      expiration { DateTime.yesterday }
    end
  end
end
