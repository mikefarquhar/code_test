class Classroom < ApplicationRecord
  belongs_to :teacher, class_name: "User", inverse_of: :taught_classrooms
  has_many :enrollments
  has_many :students, through: :enrollments

  validates :name, presence: true
end
