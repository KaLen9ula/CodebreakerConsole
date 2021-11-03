require_relative 'spec_helper'

RSpec.describe Console do
  subject(:view_module) { ConsoleGame::View }

  let(:game) { described_class.new }
  let(:name) { 'name' }
  let(:wrong_name) { 'bo' }
  let(:difficulty) { 'hell' }
  let(:wrong_difficulty) { 'hard' }

  describe '#run' do
    after do
      game.run
    rescue SystemExit
      nil
    end

    context 'with registration stage' do
      before { allow(view_module).to receive(:fetch_user_input).and_return('start', 'exit') }

      context 'when user enters name' do
        before { allow(view_module).to receive(:obtain_difficulty).and_return(difficulty) }

        it { allow(view_module).to receive(:obtain_name).and_return(name) }
      end

      context 'when name is incorrect output message' do
        before do
          allow(view_module).to receive(:obtain_name).and_return(wrong_name, name)
          allow(view_module).to receive(:obtain_difficulty).and_return(difficulty)
        end

        it { expect(view_module).to receive(:name_length_error) }
      end

      context 'when user enters difficulty' do
        before { allow(view_module).to receive(:obtain_name).and_return(name) }

        it { allow(view_module).to receive(:obtain_difficulty).and_return(difficulty) }
      end

      context 'when difficulty is incorrect output message' do
        before do
          allow(view_module).to receive(:obtain_name).and_return(name)
          allow(view_module).to receive(:obtain_difficulty).and_return(wrong_difficulty, difficulty)
        end

        it { expect(view_module).to receive(:difficulty_input_error) }
      end
    end
  end
end
