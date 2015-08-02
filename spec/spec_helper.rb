# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

require 'capybara/rspec'
require 'capybara/poltergeist'
require 'yaml'


if ENV['IN_BROWSER']
  Capybara.default_driver = :selenium
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :firefox)
  end
else
  options = {
      :js_errors => false,
      :timeout => 180,
      :window_size => [1280, 1024],
      :debug => false,
      :phantomjs_options => ['--ignore-ssl-errors=true', '--ssl-protocol=tlsv1'],
      :inspector => false
  }
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app,options)
  end
  Capybara.default_driver    = :poltergeist
  Capybara.javascript_driver = :poltergeist
  Capybara.automatic_reload
end

def config
  config_file = "#{File.dirname(__FILE__)}/config_test.yml"
  if  ENV['CONFIG_FILE']
    config_file = "#{File.dirname(__FILE__)}/" + ENV['CONFIG_FILE']
  end
  puts "config_file: " + config_file
  YAML.load_file(config_file)
end

def rest
  sleep config['sleep_time']
end

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

    