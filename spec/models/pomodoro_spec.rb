# == Schema Information
#
# Table name: pomodoros
#
#  id         :integer          not null, primary key
#  task_id    :integer          not null
#  box        :integer          not null
#  done       :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_pomodoros_on_task_id  (task_id)
#
# Foreign Keys
#
#  fk_rails_...  (task_id => tasks.id)
#

require 'rails_helper'

RSpec.describe Pomodoro, type: :model do
  let(:pomodoro) { build :pomodoro }

  it 'has a valid factory' do
    expect(pomodoro).to be_valid
  end

  describe 'before_destroy :can_delete_only_last' do
    let(:task) { create :task }
    let!(:first_pomodoro) { create :pomodoro, task: task }
    let!(:second_pomodoro) { create :pomodoro, task: task }
    let!(:last_pomodoro) { create :pomodoro, task: task }

    context '正常系' do
      context '最後のポモドーロを削除する時' do
        subject { last_pomodoro.destroy }

        it '削除できる' do
          expect { subject }.to change { task.pomodoros.size }.from(3).to(2)
        end
      end
    end

    context '異常系' do
      context '最初のポモドーロを削除する時' do
        subject { first_pomodoro.destroy }

        it '削除されない' do
          expect { subject }.not_to change { task.pomodoros.size }
        end

        it 'バリデーションエラーになる' do
          subject
          expect(first_pomodoro.errors.full_messages.first).to eq '最後のポモドーロしか削除できません'
        end
      end

      context '２番目のポモドーロを削除する時' do
        subject { second_pomodoro.destroy }

        it '削除されない' do
          expect { subject }.not_to change { task.pomodoros.size }
        end

        it 'バリデーションエラーになる' do
          subject
          expect(second_pomodoro.errors.full_messages.first).to eq '最後のポモドーロしか削除できません'
        end
      end
    end
  end
end
