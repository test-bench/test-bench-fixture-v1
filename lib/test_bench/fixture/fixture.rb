module TestBench
  module Fixture
    Error = Class.new(RuntimeError)

    def self.build(cls, *args, session: nil, output: nil, error_policy: nil, factory_method: nil, **kwargs, &block)
      factory_method = factory_method(cls)

      if kwargs.empty?
        instance = factory_method.(*args, &block)
      else
        instance = factory_method.(*args, **kwargs, &block)
      end

      Session.configure(instance, session: session, output: output, error_policy: error_policy)

      instance
    end

    def self.factory_method(cls)
      if cls.respond_to?(:build)
        cls.method(:build)
      elsif cls.respond_to?(:new)
        cls.method(:new)
      else
        raise Error, "Must be given a class (Argument: #{cls.inspect})"
      end
    end

    def self.call(cls, *args, **kwargs, &block)
      factory_method = factory_method(cls)

      last_parameter_type, _ = factory_method.parameters.last

      if last_parameter_type == :block
        instance = build(cls, *args, **kwargs, &block)
        block = nil
      else
        instance = build(cls, *args, **kwargs)
      end

      instance.test_session.fixture(instance, &block)

      instance
    end

    def test_session
      @test_session ||= Session::Substitute.build
    end
    attr_writer :test_session
    alias_method :session, :test_session
    alias_method :session=, :test_session=

    def comment(text)
      test_session.comment(text)
    end

    ArgumentOmitted = Object.new
    def assert(value=ArgumentOmitted, caller_location: nil, &block)
      caller_location ||= caller_locations.first

      unless value == ArgumentOmitted
        unless block.nil?
          raise ArgumentError, "Must supply a boolean value or a block (but not both)"
        end

        test_session.assert(value, caller_location: caller_location)
      else
        test_session.assert_block(caller_location: caller_location, &block)
      end
    end

    def refute(value, caller_location: nil)
      caller_location ||= caller_locations.first

      test_session.assert(!value, caller_location: caller_location)
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
        comment "Possible Error: #{error_class}#{' (strict)' if strict}"

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
      test_session.context(text, &block)
    end

    def test(text=nil, &block)
      test_session.test(text, &block)
    end

    def fixture(cls, *args, **kwargs, &block)
      Fixture.(cls, *args, session: test_session, **kwargs, &block)
    end
  end
end
