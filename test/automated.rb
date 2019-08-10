require_relative './test_init'

if defined?(TestBench::Bootstrap)
  TestBench::Bootstrap::Run.()
else
  TestBench::CLI.() or exit(false)
end
