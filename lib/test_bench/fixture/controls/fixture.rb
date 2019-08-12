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
        end

        module FactoryMethod
          def self.example
            Example.build
          end

          Example = Fixture.example_class do
            attr_accessor :build_method_called
            alias_method :build_method_called?, :build_method_called

            def self.build
              instance = new
              instance.build_method_called = true
              instance
            end
          end
        end

        module ConstructorArguments
          Example = Fixture.example_class do
            include Fixture

            attr_reader :arg1, :arg2, :arg3, :arg4

            def initialize(arg1, arg2=nil, arg3:, arg4: nil)
              @arg1, @arg2, @arg3, @arg4 = arg1, arg2, arg3, arg4
            end
          end

          module FactoryMethod
            Example = Class.new(Example) do
              def initialize(arg1, arg2, arg3, arg4)
                @arg1, @arg2, @arg3, @arg4 = arg1, arg2, arg3, arg4
              end

              def self.build(arg1, arg2=nil, arg3:, arg4: nil)
                new(arg1, arg2, arg3, arg4)
              end
            end
          end
        end

        Example = example_class
      end
    end
  end
end
