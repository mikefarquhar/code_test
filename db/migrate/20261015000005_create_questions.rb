class CreateQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :questions do |t|
      t.references :skill, null: false, foreign_key: true
      t.string :prompt, null: false
      t.string :correct_answer, null: false

      t.timestamps
    end
  end
end
