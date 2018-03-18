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

require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { create :project }

  it 'has a valid factory' do
    expect(project).to be_valid
  end

  describe '#stop' do
    subject { project.stop }

    context '正常系' do
      context 'デフォルトプロジェクトでない時' do
        let!(:project) { create :project, name: 'not default project' }

        it 'プロジェクトを停止する' do
          expect { subject }.to change { project.stopped_at? }.from(false).to(true)
        end
      end
    end

    context '異常系' do
      shared_examples 'プロジェクトを停止しない' do
        it { expect { subject }.not_to change { project.reload.stopped? } }
      end

      context 'デフォルトプロジェクトの時' do
        let!(:project) { create :project, name: Constants::DEFAULT_PROJECT_NAME }

        before { project.update_attribute(:is_default, true) }

        it_behaves_like 'プロジェクトを停止しない'

        it 'バリデーションエラーメッセージが正しい' do
          subject
          expect(project.errors.full_messages.first).to eq 'デフォルトプロジェクトは停止できません'
        end
      end

      context '本日以降のタスクが紐づいている時' do
        let!(:project) { create :project }

        before { create :task, project: project, todo_on: Date.current }

        it_behaves_like 'プロジェクトを停止しない'

        it 'バリデーションエラーメッセージが正しい' do
          subject
          expect(project.errors.full_messages.first).to eq '本日以降のタスクが紐づいたプロジェクトは停止できません'
        end
      end
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

      before { project.update_attribute(:is_default, true) }

      it '削除されない' do
        expect { subject }.not_to change { Project.count }
      end

      it 'バリデーションエラーメッセージが正しい' do
        subject
        expect(project.errors.full_messages.first).to eq 'デフォルトプロジェクトは削除できません'
      end
    end

    context 'デフォルトプロジェクトではない場合' do
      let!(:project) { create :project, name: 'not default project' }

      it '削除される' do
        expect { subject }.to change { Project.count }.by(-1)
      end
    end
  end

  describe 'validate :cannot_be_default' do
    subject { project.update(is_default: true) }
    let(:project) { create :project, is_default: false}

    it 'プロジェクトはデフォルトにならない' do
      expect { subject }.not_to change { project.reload.is_default }
    end

    it 'バリデーションエラーメッセージは正しい' do
      subject
      expect(project.errors.full_messages.first).to eq 'デフォルトかどうかは後から設定できません'
    end
  end
end
