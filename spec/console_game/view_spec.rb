# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe ConsoleGame::View do
  %i[obtain_guess obtain_name obtain_difficulty obtain_save obtain_new_game].each do |function_name|
    include_examples 'gets chomp', function_name
  end

  %i[menu rules menu_message_error guess_input_error name_length_error difficulty_input_error no_hints
     win].each do |function_name|
    include_examples 'puts method', function_name
  end
  include_examples 'puts method', :statistics
  include_examples 'puts method', :matrix, '+'
  include_examples 'puts method', :hint, '1'
  include_examples 'puts method', :loss, '1111'
end
