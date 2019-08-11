module TestBench
  module Fixture
    module Output
      class Log
        include Output

        attr_reader :logger

        def initialize(logger)
          @logger = logger
        end

        def self.build(device=nil)
          device ||= $stderr

          logger = Logger.new(device)

          new(logger)
        end

        def self.configure(receiver, device=nil, attr_name: nil)
          attr_name ||= :output

          instance = build(device)
          receiver.public_send(:"#{attr_name}=", instance)
          instance
        end

        def assert(result, caller_location)
          logger.info { "Assertion (Result: #{result}, Caller Location: #{caller_location})" }
        end

        def enter_assert_block(caller_location)
          logger.debug { "Entering assert block (Caller Location: #{caller_location})" }
        end

        def exit_assert_block(caller_location, result)
          logger.info { "Exited assert block (Caller Location: #{caller_location}, Result: #{result})" }
        end

        def comment(text)
          logger.info { "Comment (Text: #{text})" }
        end

        def error(error)
          logger.error { "Error (Error: #{error})" }
        end

        def start_test(title)
          logger.debug { "Starting test (Title: #{title || '(none)'})" }
        end

        def finish_test(title, result)
          logger.info { "Finished test (Title: #{title || '(none)'}, Result: #{result})" }
        end

        def skip_test(title)
          logger.info { "Skipped test (Title: #{title || '(none)'})" }
        end

        def enter_context(title)
          logger.debug { "Entering context (Title: #{title || '(none)'})" }
        end

        def exit_context(title, result)
          logger.info { "Exited context (Title: #{title || '(none)'}, Result: #{result})" }
        end

        def skip_context(title)
          logger.info { "Skipped context (Title: #{title || '(none)'})" }
        end

        def device?(device)
          logger.instance_variable_get(:@logdev) == device
        end
      end
    end
  end
end
