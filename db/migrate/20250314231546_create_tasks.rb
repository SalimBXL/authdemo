class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.string :remarks
      t.date :start_date
      t.date :due_date
      t.references :project, null: false, foreign_key: true
      t.integer :criticity, default: 0, null: false
      t.integer :level
      t.references :user, null: false, foreign_key: true
      t.integer :status, default: 0 # Correspond à :new dans l'enum

      t.timestamps
    end
    add_index :tasks, :due_date
    add_index :tasks, :level
    add_index :tasks, :status
    add_index :tasks, :criticity
  end
end
