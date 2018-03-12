# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  stopped_at :datetime
#  is_default :boolean          default(FALSE)
#
# Indexes
#
#  index_projects_on_stopped_at  (stopped_at)
#  index_projects_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Project < ApplicationRecord
  scope :without_default, -> { where(is_default: false) }
  scope :in_progress, -> { where(stopped_at: nil) }

  belongs_to :user

  has_many :tasks, dependent: :restrict_with_error

  validates :name, presence: true
  validate :cannot_stop_default_project
  validate :cannot_stop_with_tasks_after_today
  validate :cannot_be_default

  before_destroy :cannot_destroy_default_project

  def stop
    update(stopped_at: DateTime.current)
  end

  def restart
    update(stopped_at: nil)
  end

  def stopped?
    stopped_at?
  end

  private

  def cannot_destroy_default_project
    if is_default?
      errors.add(:base, 'デフォルトプロジェクトは削除できません')
      throw :abort
    end
  end

  def cannot_stop_default_project
    errors.add(:base, 'デフォルトプロジェクトは停止できません') if stopped? && is_default?
  end

  def cannot_stop_with_tasks_after_today
    errors.add(:base, '本日以降のタスクが紐づいたプロジェクトは停止できません') if stopped? && tasks.where('todo_on >= ?', Date.current).present?
  end

  def cannot_be_default
    errors.add(:is_default, 'は後から設定できません') if is_default?
  end
end
