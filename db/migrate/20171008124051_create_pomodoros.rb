class CreatePomodoros < ActiveRecord::Migration[5.1]
  def change
    create_table :pomodoros do |t|
      t.references :task, foreign_key: true, null: false
      t.integer :box, null: false
      t.boolean :done, null: false, default: false

      t.timestamps
    end
  end
end
