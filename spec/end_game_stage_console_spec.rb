require_relative 'spec_helper'

RSpec.describe Console do
  subject(:view_module) { ConsoleGame::View }

  let(:game) { described_class.new }
  let(:name) { I18n.t('specs.name') }
  let(:difficulty) { I18n.t('specs.difficulty') }

  describe '#run' do
    after do
      game.run
    rescue SystemExit
      nil
    end

    context 'when user finished game' do
      before do
        allow(view_module).to receive(:obtain_guess).and_return(I18n.t('specs.code'))
        allow(view_module).to receive(:fetch_user_input).and_return(I18n.t('menu.start'), I18n.t('menu.exit'))
        allow(view_module).to receive(:obtain_name).and_return(name)
        allow(view_module).to receive(:obtain_difficulty).and_return(difficulty)
        allow(view_module).to receive(:guess_input_error)
        allow(view_module).to receive(:matrix)
        allow(view_module).to receive(:obtain_new_game).and_return(I18n.t('menu.disagree'))
      end

      context 'when user win return win message' do
        before do
          allow(view_module).to receive(:obtain_save).and_return(I18n.t('menu.disagree'))
          allow(view_module).to receive(:obtain_guess).and_return(I18n.t('specs.code'))
          allow_any_instance_of(Codebraker::Game).to receive(:win?).and_return(true, false)
        end

        it { expect(view_module).to receive(:win) }
      end

      context 'when user lose return lose message' do
        before { allow_any_instance_of(Codebraker::Game).to receive(:lose?).and_return(true, false) }

        it { expect(view_module).to receive(:loss) }
      end
    end
  end
end
