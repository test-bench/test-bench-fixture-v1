unless RUBY_ENGINE == 'mruby'
  require 'tempfile'
end

require 'test_bench/fixture/controls/caller_location'
require 'test_bench/fixture/controls/error/backtrace'
require 'test_bench/fixture/controls/error'
require 'test_bench/fixture/controls/fixture'
require 'test_bench/fixture/controls/result'
require 'test_bench/fixture/controls/test_file'

require 'test_bench/fixture/controls/output'
require 'test_bench/fixture/controls/output/log'
