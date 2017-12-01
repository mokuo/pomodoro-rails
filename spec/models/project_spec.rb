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

require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { create :project }

  it 'has a valid factory' do
    expect(project).to be_valid
  end

  describe '#stop' do
    subject { project.stop }
    let!(:project) { create :project }

    it 'プロジェクトを停止する' do
      expect { subject }.to change { project.stopped_at? }.from(false).to(true)
    end
  end

  describe '#restart' do
    subject { project.restart }
    let!(:project) { create :project, stopped_at: DateTime.current }

    it 'プロジェクトを再開する' do
      expect { subject }.to change { project.stopped_at? }.from(true).to(false)
    end
  end

  describe '#stopped?' do
    subject { project.stopped? }

    context 'プロジェクトが停止している時' do
      let!(:project) { create :project, stopped_at: DateTime.current }

      it 'true を返す' do
        expect(subject).to be_truthy
      end
    end

    context 'プロジェクトが停止していない時' do
      let!(:project) { create :project, stopped_at: nil }

      it 'false を返す' do
        expect(subject).to be_falsy
      end
    end
  end

  describe '#destroy' do
    subject { project.destroy }

    context 'デフォルトプロジェクトの時' do
      let!(:project) { create :project, name: Constants::DEFAULT_PROJECT_NAME }

      it '削除されない' do
        expect { subject }.not_to change { Project.count }
      end
    end

    context 'デフォルトプロジェクトではない場合' do
      let!(:project) { create :project, name: 'not default project' }

      it '削除される' do
        expect { subject }.to change { Project.count }.by(-1)
      end
    end
  end
end
