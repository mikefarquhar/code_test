class Question < ApplicationRecord
  belongs_to :skill

  validates :prompt, :correct_answer, presence: true
end
