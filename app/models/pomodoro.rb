# == Schema Information
#
# Table name: pomodoros
#
#  id         :integer          not null, primary key
#  task_id    :integer          not null
#  box        :integer          not null
#  done       :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_pomodoros_on_task_id  (task_id)
#
# Foreign Keys
#
#  fk_rails_...  (task_id => tasks.id)
#

class Pomodoro < ApplicationRecord
  enum box: { square: 1, circle: 2, triangle: 3 }

  belongs_to :task

  validates_with PomodoroNumberValidator
  validates :box, presence: true, pomodoro_box: true
  validates :done, inclusion: { in: [true, false] }, pomodoro_done: true
end
