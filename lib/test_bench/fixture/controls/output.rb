module TestBench
  module Fixture
    module Controls
      module Output
        def self.example
          Example.new
        end

        def self.example_class(&block)
          Class.new do
            include TestBench::Fixture::Output

            class_exec(&block) unless block.nil?
          end
        end

        Example = example_class

        module Exercise
          def self.each_method(&block)
            result = Controls::Result.example
            path = Controls::TestFile.path
            fixture = Controls::Fixture.example
            caller_location = Controls::CallerLocation.example
            error = Controls::Error.example
            comment_text = 'Some comment'
            detail_text = 'Some detail'
            test_title = 'Some test'
            context_title = 'Some Context'

            {
              :start => [],
              :enter_file => [path],
              :exit_file => [path, result],
              :start_fixture => [fixture],
              :finish_fixture => [fixture, result],
              :assert => [result, caller_location],
              :comment => [comment_text],
              :detail => [detail_text],
              :error => [error],
              :start_test => [test_title],
              :finish_test => [test_title, result],
              :skip_test => [test_title],
              :enter_context => [context_title],
              :exit_context => [context_title, result],
              :skip_context => [context_title],
              :finish => [result]
            }.each(&block)
          end
        end
      end
    end
  end
end
