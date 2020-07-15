module TestBench
  module Fixture
    module Controls
      module Output
        module Log
          module Level
            def self.example
              fatal
            end

            def self.unknown
              :unknown
            end

            def self.fatal
              :fatal
            end

            def self.error
              :error
            end

            def self.warning
              :warning
            end

            def self.info
              :info
            end

            def self.debug
              :debug
            end

            module Invalid
              def self.example
                :not_a_log_level
              end
            end
          end
        end
      end
    end
  end
end
