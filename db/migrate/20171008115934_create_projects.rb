class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.references :user, foreign_key: true, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
