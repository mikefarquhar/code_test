class CreateClassrooms < ActiveRecord::Migration[7.2]
  def change
    create_table :classrooms do |t|
      t.string :name, null: false
      t.references :teacher, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
