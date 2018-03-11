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
  ORDER_ERROR_MSG = 'は順序通りに設定してください'

  enum box: { square: 1, circle: 2, triangle: 3 }

  belongs_to :task

  validates :box, presence: true
  validates :done, inclusion: { in: [true, false] }

  validate :verify_number
  validate :verify_box_type_on_create, :cannot_done_on_create, on: :create
  validate :verify_box_type_on_update, :can_done_only_from_first, :can_restart_only_from_last, on: :update

  before_destroy :can_delete_only_last

  private

  def verify_box_type_on_create
    last_pomodoro = task.pomodoros.last

    if last_pomodoro.nil?
      errors.add(:box, ORDER_ERROR_MSG) if box != 'square'
      return
    end

    case last_pomodoro.box
    when 'square'
      errors.add(:box, ORDER_ERROR_MSG) if box == 'triangle'
    when 'circle'
      errors.add(:box, ORDER_ERROR_MSG) if box == 'square'
    when 'triangle'
      errors.add(:box, ORDER_ERROR_MSG) if box != 'triangle'
    end
  end

  def verify_box_type_on_update
    index = task.pomodoros.index(self)
    if index.zero?
      errors.add(:box, ORDER_ERROR_MSG) if box != 'square'
      return
    end

    previous_pomodoro = task.pomodoros[index - 1]
    case previous_pomodoro.box
    when 'square'
      errors.add(:box, ORDER_ERROR_MSG) if box == 'triangle'
    when 'circle'
      errors.add(:box, ORDER_ERROR_MSG) if box == 'square'
    when 'triangle'
      errors.add(:box, ORDER_ERROR_MSG) if box != 'triangle'
    end

    behind_pomodoro = task.pomodoros[index + 1]
    return if behind_pomodoro.nil?
    case behind_pomodoro.box
    when 'square'
      errors.add(:box, ORDER_ERROR_MSG) if box != 'square'
    when 'circle'
      errors.add(:box, ORDER_ERROR_MSG) if box == 'triangle'
    when 'triangle'
      errors.add(:box, ORDER_ERROR_MSG) if box == 'square'
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

  def verify_number
    errors.add(:base, 'ポモドーロは６個までしか作成できません') if task.pomodoros.count == 6
  end

  def can_restart_only_from_last
    return if done
    return if task.pomodoros.last == self
    behind_pomodoro = task.pomodoros[task.pomodoros.index(self) + 1]
    return unless behind_pomodoro.done
    errors.add(:done, 'の取り消しは最後からしかできません')
  end
end
