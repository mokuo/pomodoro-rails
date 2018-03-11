class PomodoroNumberValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add(:base, 'ポモドーロは６個までしか作成できません') if record.task.pomodoros.count == 6
  end
end
