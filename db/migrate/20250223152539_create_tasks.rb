class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.date :start_date
      t.date :due_date
      t.references :level, null: false, foreign_key: true
      t.text :description
      t.integer :user_id
      t.text :remarks
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
