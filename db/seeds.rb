# Deterministic and idempotent: safe to run repeatedly.

QUESTIONS_PER_SKILL = 20

GENERATORS = {
  "Two-digit addition" => lambda { |r|
    a = r.rand(10..89)
    b = r.rand(10..89)
    ["What is #{a} + #{b}?", (a + b).to_s]
  },
  "Two-digit subtraction" => lambda { |r|
    a = r.rand(40..99)
    b = r.rand(10..39)
    ["What is #{a} - #{b}?", (a - b).to_s]
  },
  "Multiplication facts" => lambda { |r|
    a = r.rand(2..12)
    b = r.rand(2..12)
    ["What is #{a} × #{b}?", (a * b).to_s]
  },
  "Division facts" => lambda { |r|
    divisor = r.rand(2..12)
    quotient = r.rand(2..12)
    ["What is #{divisor * quotient} ÷ #{divisor}?", quotient.to_s]
  },
  "One-step equations" => lambda { |r|
    x = r.rand(2..20)
    a = r.rand(3..30)
    ["Solve for x: x + #{a} = #{x + a}", x.to_s]
  }
}.freeze

rng = Random.new(42)

GENERATORS.each do |skill_name, generator|
  skill = Skill.find_or_create_by!(name: skill_name)

  questions = {}
  questions.store(*generator.call(rng)) while questions.size < QUESTIONS_PER_SKILL

  questions.each do |prompt, answer|
    Question.find_or_create_by!(skill: skill, prompt: prompt) { |q| q.correct_answer = answer }
  end
end

teachers = [
  ["Ms. Rivera", "Eastern Time (US & Canada)"],
  ["Mr. Okafor", "Pacific Time (US & Canada)"]
].map do |name, zone|
  User.find_or_create_by!(name: name, role: "teacher") { |u| u.time_zone = zone }
end

students = [
  ["Ava Chen", "Eastern Time (US & Canada)"],
  ["Ben Ortiz", "Eastern Time (US & Canada)"],
  ["Chloe Patel", "Central Time (US & Canada)"],
  ["Dev Sharma", "Central Time (US & Canada)"],
  ["Elena Rossi", "Mountain Time (US & Canada)"],
  ["Finn Murphy", "Pacific Time (US & Canada)"],
  ["Grace Kim", "Pacific Time (US & Canada)"],
  ["Hugo Silva", "Pacific Time (US & Canada)"],
  ["Isla Nguyen", "Hawaii"],
  ["Jamal Brooks", "Alaska"]
].map do |name, zone|
  User.find_or_create_by!(name: name, role: "student") { |u| u.time_zone = zone }
end

{ teachers[0] => ["Period 1 Math", students.first(5)],
  teachers[1] => ["Period 3 Math", students.last(5)] }.each do |teacher, (classroom_name, roster)|
  classroom = Classroom.find_or_create_by!(name: classroom_name, teacher: teacher)
  roster.each { |student| Enrollment.find_or_create_by!(classroom: classroom, student: student) }
end

unless Rails.env.test?
  puts "Seeded #{Skill.count} skills, #{Question.count} questions"
  puts "\nUsers (send the id in the X-User-Id header):"
  User.order(:id).each { |u| puts format("  %-3d %-8s %s", u.id, u.role, u.name) }
end
