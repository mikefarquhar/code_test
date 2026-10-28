class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :role, null: false
      t.string :time_zone, null: false, default: "UTC"

      t.timestamps
    end

    add_index :users, :role
  end
end
