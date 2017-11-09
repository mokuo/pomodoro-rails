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

class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project, optional: true

  has_many :pomodoros, dependent: :destroy

  validates :name, presence: true
  validates :done, inclusion: { in: [true, false] }
  validates :todo_on, presence: true
end
