class User < ApplicationRecord
  enum :role, { student: "student", teacher: "teacher" }, validate: true

  has_many :taught_classrooms, class_name: "Classroom", foreign_key: :teacher_id, inverse_of: :teacher
  has_many :enrollments, foreign_key: :student_id, inverse_of: :student
  has_many :classrooms, through: :enrollments

  validates :name, presence: true
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.all.map(&:name) + ["UTC"] }
end
