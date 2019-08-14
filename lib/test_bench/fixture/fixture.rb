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
  end
end
