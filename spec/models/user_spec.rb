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
  let(:user) { build :user }

  it 'has a valid factory' do
    expect(user).to be_valid
  end

  describe 'after_create :create_default_project' do
    subject { create(:user) }

    it '作成されたユーザーに紐付くデフォルトプロジェクトを作成する' do
      expect { subject }.to change { Project.count }.by(1)
      expect(Project.last.user).to eq User.last
      expect(Project.last.name).to eq Constants::DEFAULT_PROJECT_NAME
    end
  end
end
