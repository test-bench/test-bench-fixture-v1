module TestBench
  module Fixture
    def self.build(cls, *args, run: nil, output: nil, error_policy: nil, factory_method: nil, **kwargs)
      if cls.respond_to?(:build)
        factory_method ||= :build
      else
        factory_method ||= :new
      end

      args << kwargs unless kwargs.empty?

      instance = cls.public_send(factory_method, *args)
      Run.configure(instance, run: run, output: output, error_policy: error_policy)
      instance
    end

    def self.call(cls, *args, **kwargs, &block)
      instance = build(cls, *args, **kwargs)

      if block.nil?
        instance.()
      else
        instance.instance_exec(instance, &block)
      end

      instance
    end

    def test_run
      @test_run ||= Run::Substitute.build
    end
    attr_writer :test_run
    alias_method :run, :test_run
    alias_method :run=, :test_run=

    def comment(text)
      test_run.comment(text)
    end

    ArgumentOmitted = Object.new
    def assert(value=ArgumentOmitted, caller_location: nil, &block)
      caller_location ||= caller_locations.first

      unless value == ArgumentOmitted
        unless block.nil?
          raise ArgumentError, "Must supply a boolean value or a block (but not both)"
        end

        test_run.assert(value, caller_location: caller_location)
      else
        test_run.assert_block(caller_location: caller_location, &block)
      end
    end

    def refute(value, caller_location: nil)
      caller_location ||= caller_locations.first

      test_run.assert(!value, caller_location: caller_location)
    end
  end
end
