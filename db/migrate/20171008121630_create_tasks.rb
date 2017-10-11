class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.references :user, foreign_key: true, null: false
      t.references :project, foreign_key: true, null: false
      t.string :name, null: false
      t.boolean :done, null: false, default: false

      t.timestamps
    end
  end
end
