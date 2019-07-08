class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.date :deadline
      t.boolean :completed
      t.integer :sort_priority
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
