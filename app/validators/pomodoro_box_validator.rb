class PomodoroBoxValidator < ActiveModel::EachValidator
  ORDER_ERROR_MSG = 'は順序通りに設定してください'

  def validate_each(record, attribute, value)
    if record.new_record?
      verify_box_on_create(record, attribute, value)
    else
      verify_box_on_update(record, attribute, value)
    end
  end

  private

  def verify_box_on_create(pomodoro, box, value)
    last_pomodoro = pomodoro.task.pomodoros.last

    if last_pomodoro.nil?
      pomodoro.errors.add(box, ORDER_ERROR_MSG) if value != 'square'
      return
    end

    verify_box_by_previous_pomodoro(pomodoro, box, value, last_pomodoro)
  end

  def verify_box_on_update(pomodoro, box, value)
    index = pomodoro.task.pomodoros.index(pomodoro)
    if index.zero?
      pomodoro.errors.add(box, ORDER_ERROR_MSG) if value != 'square'
      return
    end

    previous_pomodoro = pomodoro.task.pomodoros[index - 1]
    verify_box_by_previous_pomodoro(pomodoro, box, value, previous_pomodoro)

    behind_pomodoro = pomodoro.task.pomodoros[index + 1]
    return if behind_pomodoro.nil?
    case behind_pomodoro.box
    when 'square'
      pomodoro.errors.add(box, ORDER_ERROR_MSG) if value != 'square'
    when 'circle'
      pomodoro.errors.add(box, ORDER_ERROR_MSG) if value == 'triangle'
    when 'triangle'
      pomodoro.errors.add(box, ORDER_ERROR_MSG) if value == 'square'
    end
  end

  def verify_box_by_previous_pomodoro(pomodoro, box, value, previous_pomodoro)
    case previous_pomodoro.box
    when 'square'
      pomodoro.errors.add(box, ORDER_ERROR_MSG) if value == 'triangle'
    when 'circle'
      pomodoro.errors.add(box, ORDER_ERROR_MSG) if value == 'square'
    when 'triangle'
      pomodoro.errors.add(box, ORDER_ERROR_MSG) if value != 'triangle'
    end
  end
end
