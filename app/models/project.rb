# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_projects_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Project < ApplicationRecord
  belongs_to :user
end
