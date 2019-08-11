unless RUBY_ENGINE == 'mruby'
  require 'logger'
  require 'stringio'
end

require 'test_bench/fixture/assertion_failure'

require 'test_bench/fixture/output'
require 'test_bench/fixture/output/null'
require 'test_bench/fixture/output/log'
require 'test_bench/fixture/output/capture'
require 'test_bench/fixture/output/substitute'
require 'test_bench/fixture/output/substitute/scope'
require 'test_bench/fixture/output/multiple'

require 'test_bench/fixture/error_policy'

require 'test_bench/fixture/session'
