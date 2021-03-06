# frozen_string_literal: true

require 'codebraker'
require 'i18n'
require 'terminal-table'
require_relative 'view'
require_relative 'console'
I18n.load_path << Dir[['config', 'locales', '**', '*.yml'].join('/')]
I18n.config.available_locales = :en
