# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_name  (name)
#

class User < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :tasks, through: :projects
  has_many :pomodoros, through: :tasks

  validates :name, presence: true, uniqueness: true

  after_create :create_default_project

  has_secure_password

  private

  def create_default_project
    projects.create!(name: Constants::DEFAULT_PROJECT_NAME)
  end
end
