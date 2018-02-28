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

  describe 'validate :verify_box_type' do
    let(:task) { create :task }

    context '正常系' do
      shared_examples 'バリデーションエラーにならない' do
        it { expect(pomodoro).to be_valid }
      end

      context '最初のポモドーロの時' do
        context 'ボックスが四角の時' do
          let(:pomodoro) { build :pomodoro, box: 'square', task: task }

          it_behaves_like 'バリデーションエラーにならない'
        end
      end

      context '前のポモドーロのボックスが四角の時' do
        before { create :pomodoro, box: 'square', task: task }

        context 'ボックスが四角の時' do
          let(:pomodoro) { build :pomodoro, box: 'square', task: task }

          it_behaves_like 'バリデーションエラーにならない'
        end

        context 'ボックスが丸の時' do
          let(:pomodoro) { build :pomodoro, box: 'circle', task: task }

          it_behaves_like 'バリデーションエラーにならない'
        end
      end

      context '前のポモドーロのボックスが丸の時' do
        before do
          create :pomodoro, box: 'square', task: task
          create :pomodoro, box: 'circle', task: task
        end

        context 'ボックスが丸の時' do
          let(:pomodoro) { build :pomodoro, box: 'circle', task: task }

          it_behaves_like 'バリデーションエラーにならない'
        end

        context 'ボックスが三角の時' do
          let(:pomodoro) { build :pomodoro, box: 'triangle', task: task }

          it_behaves_like 'バリデーションエラーにならない'
        end
      end

      context '前のポモドーロのボックスが丸の時' do
        context 'ボックスが三角の時' do
          let(:pomodoro) { build :pomodoro, box: 'triangle', task: task }

          before do
            create :pomodoro, box: 'square', task: task
            create :pomodoro, box: 'circle', task: task
            create :pomodoro, box: 'triangle', task: task
          end

          it_behaves_like 'バリデーションエラーにならない'
        end
      end
    end

    context '異常系' do
      shared_examples 'バリデーションエラーになる' do
        it { expect(pomodoro).to be_invalid }

        it 'バリデーションエラーメッセージが正しい' do
          pomodoro.valid?
          expect(pomodoro.errors.full_messages.first).to eq 'ボックスは順序通りに設定してください'
        end
      end

      context '最初のポモドーロの時' do
        context 'ボックスが丸の時' do
          let(:pomodoro) { build :pomodoro, box: 'circle', task: task }

          it_behaves_like 'バリデーションエラーになる'
        end

        context 'ボックスが三角の時' do
          let(:pomodoro) { build :pomodoro, box: 'triangle', task: task }

          it_behaves_like 'バリデーションエラーになる'
        end
      end

      context '前のポモドーロのボックスが四角の時' do
        before { create :pomodoro, box: 'square', task: task }

        context 'ボックスが三角の時' do
          let(:pomodoro) { build :pomodoro, box: 'triangle', task: task }

          it_behaves_like 'バリデーションエラーになる'
        end
      end

      context '前のポモドーロのボックスが丸の時' do
        before do
          create :pomodoro, box: 'square', task: task
          create :pomodoro, box: 'circle', task: task
        end

        context 'ボックスが四角の時' do
          let(:pomodoro) { build :pomodoro, box: 'square', task: task }

          it_behaves_like 'バリデーションエラーになる'
        end
      end

      context '前のポモドーロのボックスが三角の時' do
        before do
          create :pomodoro, box: 'square', task: task
          create :pomodoro, box: 'circle', task: task
          create :pomodoro, box: 'triangle', task: task
        end

        context 'ボックスが四角の時' do
          let(:pomodoro) { build :pomodoro, box: 'square', task: task }

          it_behaves_like 'バリデーションエラーになる'
        end

        context 'ボックスが丸の時' do
          let(:pomodoro) { build :pomodoro, box: 'circle', task: task }

          it_behaves_like 'バリデーションエラーになる'
        end
      end
    end
  end
end
