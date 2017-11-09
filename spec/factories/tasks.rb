# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  done       :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :integer
#  todo_on    :date
#
# Indexes
#
#  index_tasks_on_project_id  (project_id)
#  index_tasks_on_todo_on     (todo_on)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#

FactoryGirl.define do
  factory :task do
    project
    name 'テストタスク'
    todo_on { Date.current }
  end
end
