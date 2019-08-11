module TestBench
  module Fixture
    module Controls
      module Error
        module Backtrace
          def self.example(depth: nil)
            depth ||= self.depth

            controls = [
              CallerLocation,
              CallerLocation::Alternate,
              CallerLocation::Alternate
            ].cycle.first(depth)

            controls.map.with_index do |control, index|
              line_number = index + 1

              caller_location = control.example(line_number: line_number)

              caller_location.to_s
            end
          end

          def self.depth
            3
          end
        end
      end
    end
  end
end
