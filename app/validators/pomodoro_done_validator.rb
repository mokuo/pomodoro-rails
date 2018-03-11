class PomodoroDoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.new_record?
      cannot_done_on_create(record, attribute, value)
    else
      can_done_only_from_first(record, attribute, value)
      can_restart_only_from_last(record, attribute, value)
    end
  end

  private

  def cannot_done_on_create(pomodoro, _done, value)
    pomodoro.errors.add(:done, 'は作成時にはできません') if value
  end

  def can_done_only_from_first(pomodoro, done, value)
    return unless value
    return if pomodoro.task.pomodoros.first == pomodoro
    previous_pomodoro = pomodoro.task.pomodoros[pomodoro.task.pomodoros.index(pomodoro) - 1]
    return if previous_pomodoro.done
    pomodoro.errors.add(done, 'は先頭からしかできません')
  end

  def can_restart_only_from_last(pomodoro, done, value)
    return if value
    return if pomodoro.task.pomodoros.last == pomodoro
    behind_pomodoro = pomodoro.task.pomodoros[pomodoro.task.pomodoros.index(pomodoro) + 1]
    return unless behind_pomodoro.done
    pomodoro.errors.add(done, 'の取り消しは最後からしかできません')
  end
end
