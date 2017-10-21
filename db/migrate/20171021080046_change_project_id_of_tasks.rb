class ChangeProjectIdOfTasks < ActiveRecord::Migration[5.1]
  def change
    remove_reference :tasks, :project, index: true, foreign_key: true, null: false
    add_reference :tasks, :project, index: true, foreign_key: true, null: true
  end
end
