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

  describe 'validate :verify_box_type_on_create, on: :create' do
    let(:task) { create :task }

    context '正常系' do
      shared_examples 'ポモドーロは正常である' do
        it { expect(pomodoro).to be_valid }
      end

      context '最初のポモドーロの時' do
        context 'ボックスが四角の時' do
          let(:pomodoro) { build :pomodoro, box: 'square', task: task }

          it_behaves_like 'ポモドーロは正常である'
        end
      end

      context '前のポモドーロのボックスが四角の時' do
        before { create :pomodoro, box: 'square', task: task }

        context 'ボックスが四角の時' do
          let(:pomodoro) { build :pomodoro, box: 'square', task: task }

          it_behaves_like 'ポモドーロは正常である'
        end

        context 'ボックスが丸の時' do
          let(:pomodoro) { build :pomodoro, box: 'circle', task: task }

          it_behaves_like 'ポモドーロは正常である'
        end
      end

      context '前のポモドーロのボックスが丸の時' do
        before do
          create :pomodoro, box: 'square', task: task
          create :pomodoro, box: 'circle', task: task
        end

        context 'ボックスが丸の時' do
          let(:pomodoro) { build :pomodoro, box: 'circle', task: task }

          it_behaves_like 'ポモドーロは正常である'
        end

        context 'ボックスが三角の時' do
          let(:pomodoro) { build :pomodoro, box: 'triangle', task: task }

          it_behaves_like 'ポモドーロは正常である'
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

          it_behaves_like 'ポモドーロは正常である'
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

  describe 'varidate :verify_box_type_on_update, on: :update' do
    let(:task) { create :task }

    context '正常系' do
      context '前のポモドーロのボックスが四角の時' do
        before { create :pomodoro, box: 'square', task: task }

        context 'ボックスが四角の時' do
          subject { pomodoro.update(box: 'square') }
          let!(:pomodoro) { create :pomodoro, box: 'circle', task: task }

          it '更新できる' do
            expect { subject }.to change { pomodoro.reload.box }.from('circle').to('square')
          end
        end

        context 'ボックスが丸の時' do
          subject { pomodoro.update(box: 'circle') }
          let!(:pomodoro) { create :pomodoro, box: 'square', task: task }

          it '更新できる' do
            expect { subject }.to change { pomodoro.reload.box }.from('square').to('circle')
          end
        end
      end

      context '前のポモドーロのボックスが丸の時' do
        before do
          create :pomodoro, box: 'square', task: task
          create :pomodoro, box: 'circle', task: task
        end

        context 'ボックスが丸の時' do
          subject { pomodoro.update(box: 'circle') }
          let!(:pomodoro) { create :pomodoro, box: 'triangle', task: task }

          it '更新できる' do
            expect { subject }.to change { pomodoro.reload.box }.from('triangle').to('circle')
          end
        end

        context 'ボックスが三角の時' do
          subject { pomodoro.update(box: 'triangle') }
          let!(:pomodoro) { create :pomodoro, box: 'circle', task: task }

          it '更新できる' do
            expect { subject }.to change { pomodoro.reload.box }.from('circle').to('triangle')
          end
        end
      end

      context '後ろのポモドーロが丸の時' do
        context 'ボックスが四角の時' do
          subject { pomodoro.update(box: 'square') }
          let!(:previous_pomodoro) { create :pomodoro, box: 'square', task: task }
          let!(:pomodoro) { create :pomodoro, box: 'circle', task: task }
          let!(:behind_pomodoro) { create :pomodoro, box: 'circle', task: task }

          it '更新できる' do
            expect { subject }.to change { pomodoro.reload.box }.from('circle').to('square')
          end
        end

        context 'ボックスが丸の時' do
          subject { pomodoro.update(box: 'circle') }
          let!(:previous_pomodoro) { create :pomodoro, box: 'square', task: task }
          let!(:pomodoro) { create :pomodoro, box: 'square', task: task }
          let!(:behind_pomodoro) { create :pomodoro, box: 'circle', task: task }

          it '更新できる' do
            expect { subject }.to change { pomodoro.reload.box }.from('square').to('circle')
          end
        end
      end

      context '後ろのポモドーロが三角の時' do
        context 'ボックスが丸の時' do
          subject { pomodoro.update(box: 'circle') }
          let!(:previous_pomodoro1) { create :pomodoro, box: 'square', task: task }
          let!(:previous_pomodoro2) { create :pomodoro, box: 'circle', task: task }
          let!(:pomodoro) { create :pomodoro, box: 'triangle', task: task }
          let!(:behind_pomodoro) { create :pomodoro, box: 'triangle', task: task }

          it '更新できる' do
            expect { subject }.to change { pomodoro.reload.box }.from('triangle').to('circle')
          end
        end

        context 'ボックスが三角の時' do
          subject { pomodoro.update(box: 'triangle') }
          let!(:previous_pomodoro1) { create :pomodoro, box: 'square', task: task }
          let!(:previous_pomodoro2) { create :pomodoro, box: 'circle', task: task }
          let!(:pomodoro) { create :pomodoro, box: 'circle', task: task }
          let!(:behind_pomodoro) { create :pomodoro, box: 'triangle', task: task }

          it '更新できる' do
            expect { subject }.to change { pomodoro.reload.box }.from('circle').to('triangle')
          end
        end
      end
    end

    context '異常系' do
      shared_examples 'ポモドーロが更新されない' do
        it 'ボックスが更新されない' do
          expect { subject }.not_to change { pomodoro.reload.box }
        end

        it 'バリデーションエラーが正しい' do
          subject
          expect(pomodoro.errors.full_messages.first).to eq 'ボックスは順序通りに設定してください'
        end
      end

      context '最初のポモドーロの時' do
        let!(:pomodoro) { create :pomodoro, box: 'square', task: task }

        context 'ボックスが丸の時' do
          subject { pomodoro.update(box: 'circle') }

          it_behaves_like 'ポモドーロが更新されない'
        end

        context 'ボックスが三角の時' do
          subject { pomodoro.update(box: 'triangle') }

          it_behaves_like 'ポモドーロが更新されない'
        end
      end

      context '前のポモドーロのボックスが四角の時' do
        before { create :pomodoro, box: 'square', task: task }

        context 'ボックスが三角の時' do
          subject { pomodoro.update(box: 'triangle') }
          let(:pomodoro) { create :pomodoro, box: 'circle', task: task }

          it_behaves_like 'ポモドーロが更新されない'
        end
      end

      context '前のポモドーロのボックスが丸の時' do
        before do
          create :pomodoro, box: 'square', task: task
          create :pomodoro, box: 'circle', task: task
        end

        context 'ボックスが四角の時' do
          subject { pomodoro.update(box: 'square') }
          let(:pomodoro) { create :pomodoro, box: 'circle', task: task }

          it_behaves_like 'ポモドーロが更新されない'
        end
      end

      context '前のポモドーロのボックスが三角の時' do
        before do
          create :pomodoro, box: 'square', task: task
          create :pomodoro, box: 'circle', task: task
          create :pomodoro, box: 'triangle', task: task
        end

        context 'ボックスが四角の時' do
          subject { pomodoro.update(box: 'square') }
          let(:pomodoro) { create :pomodoro, box: 'triangle', task: task }

          it_behaves_like 'ポモドーロが更新されない'
        end

        context 'ボックスが丸の時' do
          subject { pomodoro.update(box: 'circle') }
          let(:pomodoro) { create :pomodoro, box: 'triangle', task: task }

          it_behaves_like 'ポモドーロが更新されない'
        end
      end

      context '後ろのポモドーロのボックスが四角の時' do
        context 'ボックスが丸の時' do
          subject { pomodoro.update(box: 'circle') }
          let!(:pomodoro) { create :pomodoro, box: 'square', task: task }
          let!(:behind_pomodoro) { create :pomodoro, box: 'square', task: task }

          it_behaves_like 'ポモドーロが更新されない'
        end

        context 'ボックスが三角の時' do
          subject { pomodoro.update(box: 'triangle') }
          let!(:pomodoro) { create :pomodoro, box: 'square', task: task }
          let!(:behind_pomodoro) { create :pomodoro, box: 'square', task: task }

          it_behaves_like 'ポモドーロが更新されない'
        end
      end

      context '後ろのポモドーロのボックスが丸の時' do
        context 'ボックスが三角の時' do
          subject { pomodoro.update(box: 'triangle') }
          let!(:pomodoro) { create :pomodoro, box: 'square', task: task }
          let!(:behind_pomodoro) { create :pomodoro, box: 'square', task: task }

          it_behaves_like 'ポモドーロが更新されない'
        end
      end

      context '後ろのポモドーロのボックスが三角の時' do
        context 'ボックスが四角の時' do
          subject { pomodoro.update(box: 'square') }
          let!(:previous_pomodoro) { create :pomodoro, box: 'square', task: task }
          let!(:pomodoro) { create :pomodoro, box: 'circle', task: task }
          let!(:behind_pomodoro) { create :pomodoro, box: 'triangle', task: task }

          it_behaves_like 'ポモドーロが更新されない'
        end
      end
    end
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

  describe 'validate :cannot_done_on_create, on: :create' do
    context '正常系' do
      context '作成時に完了していない時' do
        let(:pomodoro) { build :pomodoro, done: false }

        it 'ポモドーロは正常である' do
          expect(pomodoro).to be_valid
        end
      end
    end

    context '異常系' do
      context '作成時に完了している時' do
        let(:pomodoro) { build :pomodoro, done: true }

        it 'バリデーションエラーになる' do
          expect(pomodoro).to be_invalid
        end

        it 'バリデーションエラーメッセージが正しい' do
          pomodoro.valid?
          expect(pomodoro.errors.full_messages.first).to eq '完了は作成時にはできません'
        end
      end
    end
  end

  describe 'validate :can_done_only_from_first, on: :update' do
    subject { pomodoro.update(done: true) }

    context '正常系' do
      shared_examples 'ポモドーロを完了できる' do
        it { expect { subject }.to change { pomodoro.done }.from(false).to(true) }
      end

      context '最初のポモドーロの時' do
        let!(:pomodoro) { create :pomodoro, done: false }

        it_behaves_like 'ポモドーロを完了できる'
      end

      context '一つ前のポモドーロが完了している時' do
        let(:task) { create :task }
        let!(:previous_pomodoro) { create :pomodoro, done: false, task: task }
        let!(:pomodoro) { create :pomodoro, done: false, task: task }

        before do
          previous_pomodoro.update(done: true)
        end

        it_behaves_like 'ポモドーロを完了できる'
      end
    end

    context '異常系' do
      context '一つ前のポモドーロが完了していない時' do
        let(:task) { create :task }
        let!(:previous_pomodoro) { create :pomodoro, done: false, task: task }
        let!(:pomodoro) { create :pomodoro, done: false, task: task, box: 'circle' }

        it '完了できない' do
          expect { subject }.not_to change { pomodoro.reload.done }
        end

        it 'バリデーションエラーメッセージが正しい' do
          subject
          expect(pomodoro.errors.full_messages.first).to eq '完了は先頭からしかできません'
        end
      end
    end
  end

  describe 'validate :verify_number' do
    let(:task) { create :task }

    context '正常系' do
      context '６個目のポモドーロの時' do
        subject { create :pomodoro, task: task }

        before { create_list :pomodoro, 5, task: task }

        it 'ポモドーロを新規作成できる' do
          expect { subject }.to change { task.pomodoros.count }.by(1)
        end
      end
    end

    context '異常系' do
      context '７個目のポモドーロの時' do
        let(:pomodoro) { build :pomodoro, task: task }

        before { create_list :pomodoro, 6, task: task }

        it 'バリデーションエラーになる' do
          expect(pomodoro).to be_invalid
        end

        it 'バリデーションエラーメッセージが正しい' do
          pomodoro.valid?
          expect(pomodoro.errors.full_messages.first).to eq 'ポモドーロは６個までしか作成できません'
        end
      end
    end
  end
end
