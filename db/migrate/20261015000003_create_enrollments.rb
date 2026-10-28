class CreateEnrollments < ActiveRecord::Migration[7.2]
  def change
    create_table :enrollments do |t|
      t.references :classroom, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :enrollments, %i[classroom_id student_id], unique: true
  end
end
