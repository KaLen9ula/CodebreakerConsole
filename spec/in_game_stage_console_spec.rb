# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe Console do
  subject(:view_module) { ConsoleGame::View }

  let(:game) { described_class.new }
  let(:name) { 'name' }
  let(:difficulty) { 'hell' }

  describe '#run' do
    after do
      game.run
    rescue SystemExit
      nil
    end

    context 'when game started' do
      before { allow(view_module).to receive(:fetch_user_input).and_return('start', 'exit') }

      context 'when guess is not correct output error message from view' do
        before do
          allow(view_module).to receive(:obtain_name).and_return(name)
          allow(view_module).to receive(:obtain_difficulty).and_return(difficulty)
          allow(view_module).to receive(:guess_input_error)
          allow(view_module).to receive(:obtain_guess).and_return('9876', 'exit')
        end

        it { expect(view_module).to receive(:guess_input_error) }
      end

      context 'with hint' do
        before do
          allow(view_module).to receive(:fetch_user_input).and_return('start', 'exit')
          allow(view_module).to receive(:obtain_name).and_return(name)
          allow(view_module).to receive(:obtain_difficulty).and_return(difficulty)
        end

        context 'when user enter hint output hint from view' do
          before { allow(view_module).to receive(:obtain_guess).and_return('hint', 'exit') }

          it { expect(view_module).to receive(:hint) }
        end

        context 'when hints is used output appropriate message from view' do
          before { allow(view_module).to receive(:obtain_guess).and_return('hint', 'hint', 'exit') }

          it { expect(view_module).to receive(:no_hints) }
        end
      end
    end
  end
end
