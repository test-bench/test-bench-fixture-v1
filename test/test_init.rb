require_relative '../init'

require 'ostruct'

unless ENV['BOOTSTRAP'] == 'off'
  require 'test_bench/bootstrap'; TestBench::Bootstrap.activate
else
  require 'test_bench'; TestBench.activate
end

require 'test_bench/fixture/controls'

include TestBench

Controls = Fixture::Controls if defined?(Fixture::Controls)
