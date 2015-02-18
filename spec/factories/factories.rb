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
    sequence(:name) { |n| "link#{n}" }
    url 'example.com'
    expiration { DateTime.tomorrow }
    user

    trait :expired do
      expiration { DateTime.yesterday }
    end
  end

  factory :event_type do
    sequence(:name) { |n| "event_type#{n}" }

    trait :require_points do
      points_required 2
    end

    trait :require_percentage_attendance do
      percentage_attendance_required 90
    end
  end

  factory :event do
    sequence(:name) { |n| "link#{n}" }
    date { DateTime.yesterday }
    semester 20151
    event_type

    trait :with_fine do
      fine 50
    end

    trait :allow_self_submit_attendance do
      self_submit_attendance true
    end

    trait :allow_self_submit_excuse do
      self_submit_excuse true
    end
  end

  factory :attendance do
    user
    event
    present true

    trait :absent do
      present false
    end

    trait :unexcused do
      excused false
    end

    trait :excuse_accepted do
      excused true
    end
  end

  factory :fine do
    attendance
    paid true

    trait :unpaid do
      paid false
    end
  end

  factory :position do
    sequence(:name) { |n| "position#{n}" }
    user
    event_type
  end
end
