require_relative 'spec_helper'
require 'pry'

RSpec.describe Console do
  subject(:view_module) { ConsoleGame::View }

  before do
    stub_const('Codebraker::FileStore::FILE_NAME', 'gamers.yml')
    stub_const('Codebraker::FileStore::FILE_DIRECTORY', 'spec/fixtures')
  end

  describe '#show_statistics' do
    context 'with statistics output' do
      before { allow(view_module).to receive(:fetch_user_input).and_return('statistics') }

      it { expect { view_module.statistics }.to output(/Players rating/).to_stdout }
    end
  end
end
