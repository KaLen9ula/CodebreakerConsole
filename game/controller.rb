require_relative 'loader'

module Game
    class Controller
        include View

        def run
            loop do
                View.menu
                case View.fetch_user_input
                when I18n.t('menu.start') then start
                when I18n.t('menu.rules') then View.rules
                when I18n.t('menu.statistics') then show_stats
                when I18n.t('menu.exit') then exit
                else View.menu_message_error end
            end
        end

        def start
            @codebreaker_game = ::Codebreaker::Game.new
            registration
            @codebreaker_game.start
            game
        end

        def registration
            name_input
            difficulty_input
        end

        def name_input
            loop do
                name = View.obtain_name
                begin
                    @codebreaker_game.user.name = name
                    break
                rescue LengthError
                    View.name_length_error
                end
            end
        end

        def input_difficulty
            loop do
                difficulty = View.obtain_difficulty
                if difficulty_is_accessable?(difficulty)
                    @codebreaker_game.difficulty = difficulty.to_sym
                    break
                else
                    View.difficulty_input_error
                end
            end
        end

        def game
            loop { break if @codebreaker_game.lose? || procced? }
            new_game
        end

        def procced?
            case guess = View.obtain_guess
            when I18n.t('menu.exit') then exit
            when I18n.t('game.hint')
                hint
                false
            else guess_passed?(guess) end
        end

        def hint
            @codebreaker_game.check_for_hints? ? View.hint(@codebreaker_game.use_hint) : View.no_hints
        end

        def guess_passed?(guess)
            matrix = @codebreaker_game.generate_signs(guess)
            @codebreaker_game.win?(matrix)
            win_screenplay
            View.matrix(matrix)
        rescue InputError
            View.guess_input_error
            false
        end

        def win_screenplay
            View.win
            @codebreaker_game.save_game(@codebreaker_game) if View.obtain_save == I18n.t('menu.agree')
        end

        def new_game
            start if View.obtain_new_game == I18n.t('menu.agree')
        end

        def accessibility_difficulty?(difficulty)
            @codebreaker_game.check_for__difficulties.keys.map(&:to_s).include?(difficulty)
        end
    end
end
