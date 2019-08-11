module TestBench
  module Fixture
    module Controls
      module Error
        def self.example(message=nil, backtrace: nil, backtrace_depth: nil, cause: nil, cls: nil)
          message ||= self.message
          cls ||= Example
          backtrace ||= Backtrace.example(depth: backtrace_depth)

          if cause == true
            cause = Cause.example
          end

          error = cls.new(message)
          error.set_backtrace(backtrace)

          if cause
            begin
              begin
                raise cause
              rescue cause.class
                raise error
              end
            rescue cls
            end
          end

          error
        end

        def self.message
          'Some error'
        end

        Example = Class.new(RuntimeError)

        module Cause
          def self.example
            Error.example("Some cause", cls: Example)
          end

          Example = Class.new(RuntimeError)
        end
      end
    end
  end
end
