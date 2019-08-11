require_relative '../automated_init'

context "Output" do
  context "Instance Methods" do
    output_cls = Class.new do
      include Fixture::Output
    end

    output = output_cls.new

    result = Controls::Result.example
    caller_location = Controls::CallerLocation.example
    error = Controls::Error.example

    {
      :assert => [result, caller_location],
      :enter_assert_block => [],
      :exit_assert_block => [result],
      :comment => ["Some text"],
      :error => [error],
      :start_test => ["Some test"],
      :finish_test => ["Some test", result],
      :skip_test => ["Some test"],
      :enter_context => ["Some Context"],
      :exit_context => ["Some Context", result],
      :skip_context => ["Some Context"]
    }.each do |method_name, arguments|
      test "Method: #{method_name}" do
        refute_raises NoMethodError do
          output.public_send(method_name, *arguments)
        end
      end
    end
  end
end
