module TestBench
  module Fixture
    module Output
      module Substitute
        def self.build
          Output.new
        end

        class Output
          include Fixture::Output

          def records
            @records ||= []
          end

          def start
            record(:start)
          end

          def finish(result)
            record(:finish, result)
          end

          def enter_file(path)
            record(:enter_file, path)
          end

          def exit_file(path, result)
            record(:exit_file, path, result)
          end

          def start_fixture(fixture)
            record(:start_fixture, fixture)
          end

          def finish_fixture(fixture, result)
            record(:finish_fixture, fixture, result)
          end

          def assert(result, caller_location)
            record(:assert, result, caller_location)
          end

          def enter_assert_block(caller_location)
            record(:enter_assert_block, caller_location)
          end

          def exit_assert_block(caller_location, result)
            record(:exit_assert_block, caller_location, result)
          end

          def comment(text)
            record(:comment, text)
          end

          def error(error)
            record(:error, error)
          end

          def start_test(title)
            record(:start_test, title)
          end

          def finish_test(title, result)
            record(:finish_test, title, result)
          end

          def skip_test(title)
            record(:skip_test, title)
          end

          def enter_context(title)
            record(:enter_context, title)
          end

          def exit_context(title, result)
            record(:exit_context, title, result)
          end

          def skip_context(title)
            record(:skip_context, title)
          end

          def record(signal, *data)
            record = Record.new(signal, data)
            records << record
            record
          end

          Record = Struct.new(:signal, :data)
        end
      end
    end
  end
end
