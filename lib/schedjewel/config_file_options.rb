# frozen_string_literal: true

class Schedjewel::ConfigFileOptions
  extend Memoist

  def initialize
    @options =
      if config_file_exists?
        YAML.load_file(config_file_path)
      else
        {}
      end
  end

  private

  memoize \
  def config_file_path
    "#{ENV.fetch('PWD')}/config/.schedjewel.yml"
  end

  def config_file_exists?
    File.exist?(config_file_path)
  end
end
