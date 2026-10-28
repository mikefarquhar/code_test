FactoryBot.define do
  factory :user, aliases: [:student] do
    sequence(:name) { |n| "Student #{n}" }
    role { "student" }
    time_zone { "UTC" }

    trait :teacher do
      sequence(:name) { |n| "Teacher #{n}" }
      role { "teacher" }
    end

    factory :teacher, traits: [:teacher]
  end

  factory :classroom do
    sequence(:name) { |n| "Classroom #{n}" }
    association :teacher
  end

  factory :enrollment do
    classroom
    association :student
  end

  factory :skill do
    sequence(:name) { |n| "Skill #{n}" }
  end

  factory :question do
    skill
    sequence(:prompt) { |n| "What is #{n} + #{n}?" }
    correct_answer { "42" }
  end
end
