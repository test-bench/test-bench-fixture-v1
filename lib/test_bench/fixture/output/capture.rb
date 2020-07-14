module TestBench
  module Fixture
    module Output
      class Capture
        include Fixture::Output

        def records
          @records ||= []
        end

        def current_context
          @current_context ||= []
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

        def comment(text)
          record(:comment, text)
        end

        def detail(text)
          record(:detail, text)
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
          record = record(:enter_context, title)

          unless title.nil?
            current_context.push(title)
          end

          record
        end

        def exit_context(title, result)
          unless title.nil?
            current_context.pop
          end

          record(:exit_context, title, result)
        end

        def skip_context(title)
          record(:skip_context, title)
        end

        def each_record(&block)
          records.each(&block)
        end

        def record(signal, *data)
          record = new_record(signal, data)
          records << record
          record
        end

        def new_record(signal, data)
          context = current_context.dup

          record = Record.build(signal, data, context)
        end

        class Record
          attr_accessor :signal
          attr_accessor :data
          attr_accessor :context

          def self.build(signal, data, context=nil)
            instance = new
            instance.signal = signal
            instance.data = data
            instance.context = context
            instance
          end

          def forward(receiver)
            receiver.public_send(signal, *data)
          end

          def ==(record)
            self.signal == record.signal &&
              self.data == record.data &&
              self.context == record.context
          end
        end
      end
    end
  end
end
