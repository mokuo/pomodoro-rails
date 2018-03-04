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

  validates :box, presence: true
  validates :done, inclusion: { in: [true, false] }

  validate :verify_box_type
  validate :cannot_done_on_create, on: :create
  validate :can_done_only_from_first, on: :update

  before_destroy :can_delete_only_last

  private

  def verify_box_type
    last_pomodoro = task.pomodoros.last

    if last_pomodoro.nil?
      errors.add(:box, 'は順序通りに設定してください') if box != 'square'
      return
    end

    case last_pomodoro.box
    when 'square'
      errors.add(:box, 'は順序通りに設定してください') if box == 'triangle'
    when 'circle'
      errors.add(:box, 'は順序通りに設定してください') if box == 'square'
    when 'triangle'
      errors.add(:box, 'は順序通りに設定してください') if box != 'triangle'
    end
  end

  def can_delete_only_last
    return if task.pomodoros.last == self
    errors.add(:base, '最後のポモドーロしか削除できません')
    throw :abort
  end

  def can_done_only_from_first
    return unless done
    return if task.pomodoros.first == self
    previous_pomodoro = task.pomodoros[task.pomodoros.index(self) - 1]
    return if previous_pomodoro.done
    errors.add(:done, 'は先頭からしかできません')
  end

  def cannot_done_on_create
    errors.add(:done, 'は作成時にはできません') if done
  end
end
