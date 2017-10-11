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
  belongs_to :task

  validates :box, numericality: { only_integer: true,
                                  greater_than_or_equal_to: 1,
                                  less_than_or_equal_to: 8 }
  validates :done, inclusion: { in: [true, false] }
end
