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

    context 'when user entered rules return rules' do
      before { allow(view_module).to receive(:fetch_user_input).and_return(I18n.t('menu.rules'), I18n.t('menu.exit')) }

      it { expect(view_module).to receive(:rules) }
    end

    context 'when user enteres statistics return stats' do
      before do
        allow(view_module).to receive(:fetch_user_input).and_return(I18n.t('menu.statistics'), I18n.t('menu.exit'))
      end

      it { expect(view_module).to receive(:statistics) }
    end

    context 'when user entered exit leave app' do
      before { allow(view_module).to receive(:fetch_user_input).and_return(I18n.t('menu.exit')) }

      it { expect { game.run }.to raise_error(SystemExit) }
    end

    context 'when user entered wrong command return error' do
      before do
        allow(view_module).to receive(:fetch_user_input).and_return(I18n.t('specs.invalid_command'),
                                                                    I18n.t('menu.exit'))
        allow(view_module).to receive(:menu)
      end

      it { expect(view_module).to receive(:menu_message_error) }
    end
  end
end
