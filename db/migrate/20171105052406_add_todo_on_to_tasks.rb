class AddTodoOnToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :todo_on, :date
    add_index :tasks, :todo_on
  end
end
