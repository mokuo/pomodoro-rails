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

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  it 'has a valid factory' do
    expect(user).to be_valid
  end
end
