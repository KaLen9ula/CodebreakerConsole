require_relative 'spec_helper'

RSpec.describe Console do
  subject(:view_module) { ConsoleGame::View }

  let(:game) { described_class.new }
  let(:name) { Faker::Internet.user_name(Codebraker::NAME_LENGTH) }
  let(:shorter_name) { 'a' * (Codebraker::NAME_LENGTH.min - 1) }
  let(:longer_name) { 'a' * (Codebraker::NAME_LENGTH.max + 1) }
  let(:difficulty) { Codebraker::DIFFICULTIES.keys[2].to_s }
  let(:wrong_difficulty) { 's' * 3 }

  describe '#run' do
    after do
      game.run
    rescue SystemExit
      nil
    end

    context 'with registration stage' do
      before { allow(view_module).to receive(:fetch_user_input).and_return(I18n.t('menu.start'), I18n.t('menu.exit')) }

      context 'when user enters name' do
        before { allow(view_module).to receive(:obtain_difficulty).and_return(difficulty) }

        it { allow(view_module).to receive(:obtain_name).and_return(name) }
      end

      context 'when name is incorrect receive error message' do
        before { allow(view_module).to receive(:obtain_difficulty).and_return(difficulty) }

        context 'when name is shorter' do
          before { allow(view_module).to receive(:obtain_name).and_return(shorter_name, name) }

          it { expect(view_module).to receive(:name_length_error) }
        end

        context 'when name is longer' do
          before { allow(view_module).to receive(:obtain_name).and_return(longer_name, name) }

          it { expect(view_module).to receive(:name_length_error) }
        end
      end

      context 'when user enters difficulty' do
        before { allow(view_module).to receive(:obtain_name).and_return(name) }

        it { allow(view_module).to receive(:obtain_difficulty).and_return(difficulty) }
      end

      context 'when difficulty is incorrect receive error message' do
        before do
          allow(view_module).to receive(:obtain_name).and_return(name)
          allow(view_module).to receive(:obtain_difficulty).and_return(wrong_difficulty, difficulty)
        end

        it { expect(view_module).to receive(:difficulty_input_error) }
      end
    end
  end
end
