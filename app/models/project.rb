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
  scope :without_default, -> { where.not(name: Constants::DEFAULT_PROJECT_NAME) }
  scope :in_progress, -> { where(stopped_at: nil) }

  belongs_to :user

  has_many :tasks, dependent: :restrict_with_error

  validates :name, presence: true

  before_destroy :protect_default_project

  def stop
    return if name == Constants::DEFAULT_PROJECT_NAME
    update(stopped_at: DateTime.current)
  end

  def restart
    update(stopped_at: nil)
  end

  def stopped?
    stopped_at?
  end

  private

  def protect_default_project
    throw :abort if name == Constants::DEFAULT_PROJECT_NAME
  end
end
