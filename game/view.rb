# frozen_string_literal: true

module ConsoleGame
  module View
    extend self
    def menu
      print_to_console('menu.info')
    end

    def rules
      print_to_console('game.rules', code_range_first: Codebraker::CODE_RANGE.first,
                                     code_range_last: Codebraker::CODE_RANGE.last,
                                     code_length: Codebraker::CODE_LENGTH)
    end

    def statistics
      print_to_console('game.stats')
    end

    def menu_message_error
      print_to_console('error.command_error')
    end

    def guess_input_error
      print_to_console('error.guess_input_error', code_length: Codebraker::CODE_LENGTH,
                                                  code_range_first: Codebraker::CODE_RANGE.first,
                                                  code_range_last: Codebraker::CODE_RANGE.last)
    end

    def name_length_error
      print_to_console('error.name_length_error')
    end

    def difficulty_input_error
      print_to_console('error.difficulty_input_error')
    end

    def win
      print_to_console('game.win')
    end

    def loss(code)
      print_to_console('game.loss', code: code)
    end

    def hint(hint)
      puts hint.to_s
    end

    def no_hints
      print_to_console('game.no_hints')
    end

    def matrix(matrix)
      print_to_console('game.matrix', matrix: matrix)
    end

    def obtain_name
      fetch_user_input(I18n.t('registration.name'))
    end

    def obtain_guess
      fetch_user_input(I18n.t('game.guess'))
    end

    def obtain_difficulty
      fetch_user_input(I18n.t('game.difficulty', easy: difficulty_output(Codebraker::DIFFICULTIES[:easy]),
                                                 medium: difficulty_output(Codebraker::DIFFICULTIES[:medium]),
                                                 hell: difficulty_output(Codebraker::DIFFICULTIES[:hell])))
    end

    def obtain_save
      fetch_user_input(I18n.t('game.save_result'))
    end

    def obtain_new_game
      fetch_user_input(I18n.t('game.new_game'))
    end

    def fetch_user_input(question = nil)
      puts question if question
      gets.chomp
    end

    private

    def difficulty_output(difficulty)
      difficulty.map { |key, value| "#{key}: #{value}" }.join(', ')
    end

    def print_to_console(key, **args)
      puts I18n.t(key, **args)
    end
  end
end
