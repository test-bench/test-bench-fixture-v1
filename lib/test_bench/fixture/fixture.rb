module TestBench
  module Fixture
    Error = Class.new(RuntimeError)

    def self.build(cls, *args, session: nil, output: nil, error_policy: nil, factory_method: nil, **kwargs, &block)
      assure_fixture(cls)

      factory_method = factory_method(cls)

      if kwargs.empty?
        instance = factory_method.(*args, &block)
      else
        instance = factory_method.(*args, **kwargs, &block)
      end

      Session.configure(instance, session: session, output: output, error_policy: error_policy)

      instance
    end

    def self.assure_fixture(cls)
      unless cls.included_modules.include?(self)
        raise Error, "Not a fixture class (Class: #{cls.inspect})"
      end
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

      if factory_method.name == :new
        last_parameter_type, _ = cls.instance_method(:initialize).parameters.last
      else
        last_parameter_type, _ = factory_method.parameters.last
      end

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

    def inspect
      original_test_session = test_session

      self.test_session = "(not inspected; class is #{original_test_session.class})"

      begin
        super
      ensure
        self.test_session = original_test_session
      end
    end

    def comment(text, *additional_lines)
      test_session.comment(text)

      additional_lines.each do |text|
        test_session.comment(text)
      end
    end

    def detail(text, *additional_lines)
      test_session.detail(text)

      additional_lines.each do |text|
        test_session.detail(text)
      end
    end

    def assert(value, caller_location: nil)
      caller_location ||= caller[0]

      test_session.assert(value, caller_location: caller_location)
    end

    def refute(value, caller_location: nil)
      caller_location ||= caller[0]

      test_session.assert(!value, caller_location: caller_location)
    end

    def assert_raises(error_class=nil, message=nil, strict: nil, caller_location: nil, &block)
      if error_class.nil?
        strict ||= false
        error_class = StandardError
      else
        strict = true if strict.nil?
      end

      caller_location ||= caller[0]

      detail "Expected Error: #{error_class}#{' (strict)' if strict}"
      detail "Expected Message: #{message.inspect}" unless message.nil?

      block.()

      detail "(No error was raised)"

    rescue error_class => error

      detail "Raised error: #{error.inspect}#{" (subclass of #{error_class})" if error.class < error_class}"

      if strict && !error.instance_of?(error_class)
        raise error
      end

      if message.nil?
        result = true
      else
        result = error.message == message
      end

      assert(result, caller_location: caller_location)

    else
      assert(false, caller_location: caller_location)
    end

    def refute_raises(error_class=nil, strict: nil, caller_location: nil, &block)
      if error_class.nil?
        strict ||= false
        error_class = StandardError
      else
        strict = true if strict.nil?
      end

      caller_location ||= caller[0]

      detail "Prohibited Error: #{error_class}#{' (strict)' if strict}"

      block.()

      detail "(No error was raised)"

      result = true

    rescue error_class => error

      detail "Raised Error: #{error.inspect}"

      if strict && !error.instance_of?(error_class)
        raise error
      end

      result = false

    ensure
      unless result.nil?
        assert(result, caller_location: caller_location)
      end
    end

    def context(text=nil, &block)
      test_session.context(text, &block)
    end

    def test(text=nil, &block)
      test_session.test(text, &block)
    end

    def test!(text=nil, &block)
      result = test(text, &block)

      unless result
        raise Session::Abort.new, "Context aborted"
      end

      result
    end

    def fixture(cls, *args, **kwargs, &block)
      Fixture.(cls, *args, session: test_session, **kwargs, &block)
    end
  end
end
