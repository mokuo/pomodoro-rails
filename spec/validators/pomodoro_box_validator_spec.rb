require 'rails_helper'

RSpec.describe PomodoroBoxValidator, type: :validator do
  describe '#validate_each' do
    let(:task) { create :task }

    context 'ポモドーロを新規作成する時' do
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

    context 'ポモドーロを更新する時' do
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
  end
end
