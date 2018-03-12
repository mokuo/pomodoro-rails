class AddIsDefaultToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :is_default, :boolean, default: false
  end
end
