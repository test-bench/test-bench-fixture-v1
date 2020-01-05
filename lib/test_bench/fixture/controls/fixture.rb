module TestBench
  module Fixture
    module Controls
      module Fixture
        def self.example
          Example.new
        end

        def self.example_class(&block)
          Class.new do
            include TestBench::Fixture

            class_exec(&block) unless block.nil?
          end
        end

        module InstanceActuator
          def self.example
            Example.new
          end

          Example = Fixture.example_class do
            attr_accessor :actuated
            alias_method :actuated?, :actuated

            def call
              self.actuated = true
            end
          end

          module Non
            def self.example
              Example.new
            end

            Example = Fixture.example_class
          end
        end

        Example = InstanceActuator::Example
      end
    end
  end
end
