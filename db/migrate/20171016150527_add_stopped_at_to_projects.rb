class AddStoppedAtToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :stopped_at, :datetime
    add_index :projects, :stopped_at
  end
end
