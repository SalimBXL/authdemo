class CreateLevels < ActiveRecord::Migration[8.0]
  def change
    create_table :levels do |t|
      t.string :level
      t.text :description

      t.timestamps
    end
  end
end
