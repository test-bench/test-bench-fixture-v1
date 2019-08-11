unless RUBY_ENGINE == 'mruby'
  require 'logger'
  require 'stringio'
end

require 'test_bench/fixture/assertion_failure'
