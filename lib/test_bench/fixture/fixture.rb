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
  end
end
