require 'rails_helper'

RSpec.describe PomodoroDoneValidator, type: :validator do
  describe '#validate_each' do
    context 'ポモドーロを新規作成する時' do
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

    context 'ポモドーロを更新する時' do
      describe '最初からのみ完了できる' do
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

      describe '最後からのみ再開できる' do
        subject { pomodoro.update(done: false) }
        let(:task) { create :task }

        context '正常系' do
          shared_examples 'ポモドーロを再開できる' do
            it { expect { subject }.to change { pomodoro.reload.done }.from(true).to(false) }
          end

          context '最後のポモドーロの時' do
            let!(:previous_pomodoro) { create :pomodoro, task: task }
            let!(:pomodoro) { create :pomodoro, task: task }

            before do
              previous_pomodoro.update(done: true)
              task.reload
              pomodoro.update(done: true)
            end

            it_behaves_like 'ポモドーロを再開できる'
          end

          context '後ろのポモドーロが完了していない時' do
            let!(:pomodoro) { create :pomodoro }
            let!(:behind_pomodoro) { create :pomodoro }

            before { pomodoro.update(done: true) }

            it_behaves_like 'ポモドーロを再開できる'
          end
        end

        context '異常系' do
          context '後ろのポモドーロが完了している時' do
            let!(:pomodoro) { create :pomodoro, task: task }
            let!(:behind_pomodoro) { create :pomodoro, task: task }

            before do
              pomodoro.update(done: true)
              task.reload
              behind_pomodoro.update(done: true)
              task.reload
            end

            it 'done は完了のままである' do
              expect { subject }.not_to change { pomodoro.reload.done }
            end

            it 'バリデーションエラーメッセージが正しい' do
              subject
              expect(pomodoro.errors.full_messages.first).to eq '完了の取り消しは最後からしかできません'
            end
          end
        end
      end
    end
  end
end
