module TestBench
  module Fixture
    module Output
      class Log
        include Output

        Error = Class.new(RuntimeError)

        attr_reader :logger

        def initialize(logger)
          @logger = logger
        end

        def self.build(device=nil, level: nil)
          device ||= $stderr
          level ||= self.default_level

          level_ordinal = level_ordinal(level)

          logger = Logger.new(device)
          logger.level = level_ordinal

          new(logger)
        end

        def self.configure(receiver, device=nil, level: nil, attr_name: nil)
          attr_name ||= :output

          instance = build(device, level: level)
          receiver.public_send(:"#{attr_name}=", instance)
          instance
        end

        def self.default_level
          :debug
        end

        def self.levels
          level_ordinals.keys
        end

        def self.level_ordinal(level)
          assure_level(level)

          level_ordinals.fetch(level)
        end

        def self.level_ordinals
          {
            :unknown => Logger::Severity::UNKNOWN,
            :fatal => Logger::Severity::FATAL,
            :error => Logger::Severity::ERROR,
            :warning => Logger::Severity::WARN,
            :info => Logger::Severity::INFO,
            :debug => Logger::Severity::DEBUG
          }
        end

        def self.assure_level(level)
          unless level_ordinals.key?(level)
            raise Error, "Unknown log level #{level.inspect} (Valid levels: #{levels.map(&:inspect) * ', '})"
          end
        end

        def start
          logger.debug { "Start" }
        end

        def finish(result)
          logger.info { "Finish (Result: #{result})" }
        end

        def enter_file(path)
          logger.debug { "Enter file (Path: #{path})" }
        end

        def exit_file(path, result)
          logger.info { "Exit file (Path: #{path}, Result: #{result})" }
        end

        def start_fixture(fixture)
          logger.debug { "Start fixture (Fixture: #{fixture.inspect})" }
        end

        def finish_fixture(fixture, result)
          logger.info { "Finish fixture (Fixture: #{fixture.inspect}, Result: #{result})" }
        end

        def assert(result, caller_location)
          logger.info { "Assertion (Result: #{result}, Caller Location: #{caller_location})" }
        end

        def comment(text)
          logger.info { "Comment (Text: #{text})" }
        end

        def detail(text)
          logger.debug { "Detail (Text: #{text})" }
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
          self.device == device
        end

        def device
          logger.instance_exec do
            @logdev.dev
          end
        end
      end
    end
  end
end
