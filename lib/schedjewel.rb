# frozen_string_literal: true

require 'memoist'
require 'yaml'

# rubocop:disable Lint/EmptyClass
class Schedjewel; end
# rubocop:enable Lint/EmptyClass

Dir["#{File.dirname(__FILE__)}/schedjewel/*.rb"].each { |file| require file }

class Schedjewel
  class << self
    extend Memoist

    memoize \
    def config_file_options
      Schedjewel::ConfigFileOptions.new
    end
  end
end
