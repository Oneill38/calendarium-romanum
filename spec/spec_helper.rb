require 'simplecov'
SimpleCov.start

# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

RSpec::Matchers.define :have_translation do |expected, locale|
  match do |actual|
    locale ||= :en
    if expected && I18n.locale == locale
      actual == expected
    else
      # with locale different from the one the spec is written for
      # just test that the string isn't left untranslated
      !(actual.nil? || actual.empty? || actual.include?('translation missing'))
    end
  end
end

require 'calendarium-romanum'
CR = CalendariumRomanum

I18n.enforce_available_locales = true
I18n.locale = ENV['LOCALE'] || :en
