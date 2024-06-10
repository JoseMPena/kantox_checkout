# frozen_string_literal: true

require 'yaml'

module FixtureHelper
  def load_fixture(name)
    YAML.load_file(File.join(__dir__, 'fixtures', "#{name}.yml"))[name]
  end
end
