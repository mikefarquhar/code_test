require "rails_helper"

RSpec.describe "db/seeds.rb" do
  it "seeds the expected data and is idempotent" do
    2.times { Rails.application.load_seed }

    expect(Skill.count).to eq(5)
    expect(Question.count).to eq(100)
    expect(Skill.all).to all(satisfy { |skill| skill.questions.count == 20 })
    expect(User.student.count).to eq(10)
    expect(User.teacher.count).to eq(2)
    expect(Classroom.count).to eq(2)
    expect(Enrollment.count).to eq(10)
  end
end
