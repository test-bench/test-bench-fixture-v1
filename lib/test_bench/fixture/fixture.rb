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

    def assert_raises(error_class=nil, message=nil, strict: nil, caller_location: nil, &block)
      if error_class.nil?
        strict ||= false
        error_class = StandardError
      else
        strict = true if strict.nil?
      end

      caller_location ||= caller_locations.first

      assert(caller_location: caller_location) do
        comment "Expected Error: #{error_class}#{' (strict)' if strict}"
        comment "Expected Message: #{message.inspect}" unless message.nil?

        block.()

        comment "(No error was raised)"

      rescue error_class => error

        comment "Raised error: #{error.inspect}#{" (subclass of #{error_class})" if error.class < error_class}"

        if strict && !error.instance_of?(error_class)
          raise error
        end

        assert(message.nil? || error.message == message)
      end
    end

    def refute_raises(error_class=nil, strict: nil, caller_location: nil, &block)
      if error_class.nil?
        strict ||= false
        error_class = StandardError
      else
        strict = true if strict.nil?
      end

      caller_location ||= caller_locations.first

      assert(caller_location: caller_location) do
        comment "Expected Error: #{error_class}#{' (strict)' if strict}"

        block.()

        comment "(No error was raised)"

        assert(true)

      rescue error_class => error

        comment "Raised Error: #{error.inspect}"

        if strict && !error.instance_of?(error_class)
          raise error
        end
      end
    end

    def context(text=nil, &block)
      test_run.context(text, &block)
    end

    def test(text=nil, &block)
      test_run.test(text, &block)
    end

    def fixture(cls, *args, **kwargs, &block)
      Fixture.(cls, *args, run: test_run, **kwargs, &block)
    end
  end
end
