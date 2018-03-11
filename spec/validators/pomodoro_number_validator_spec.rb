require 'rails_helper'

RSpec.describe PomodoroNumberValidator, type: :validator do
  describe '#validate_each' do
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
