module TestBench
  module Fixture
    module Output
      module Substitute
        def self.build
          Output.new
        end

        MatchError = Class.new(RuntimeError)

        class Output
          include Fixture::Output

          def records
            @records ||= []
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

          def recorded?(signal=nil, &block)
            matching_records(signal, &block).any?
          end

          def one_record(signal=nil, &block)
            matching_records = matching_records(signal, &block)

            return if matching_records.empty?

            unless matching_records.one?
              raise MatchError, "More than one records match"
            end

            matching_records.shift
          end

          def matching_records(signal=nil, &block)
            unless signal.nil?
              inner_block = block || proc { true }

              block = proc { |sig, *data|
                if sig == signal
                  inner_block.(*data)
                else
                  false
                end
              }
            end

            records.select do |record|
              block.(record.signal, *record.data)
            end
          end

          Record = Struct.new(:signal, :data)
        end
      end
    end
  end
end
