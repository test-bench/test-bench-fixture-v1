module TestBench
  module Fixture
    module Output
      module Substitute
        class Output
          class Scope < Output
            attr_writer :records

            def self.build(records)
              instance = new
              instance.records = records
              instance
            end

            def combine(scope)
              combined_records = self.records + scope.records

              Scope.build(combined_records)
            end
            alias_method :+, :combine
          end
        end
      end
    end
  end
end
