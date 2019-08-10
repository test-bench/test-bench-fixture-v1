require_relative '../init'

unless RUBY_ENGINE == 'mruby'
  require 'ostruct'
end

unless ENV['BOOTSTRAP'] == 'off'
  require 'test_bench/bootstrap'; TestBench::Bootstrap.activate
else
  require 'test_bench'; TestBench.activate
end

require 'test_bench/fixture/controls'

include TestBench

Controls = Fixture::Controls if Object.const_defined?(:Fixture) && Fixture.const_defined?(:Controls)
