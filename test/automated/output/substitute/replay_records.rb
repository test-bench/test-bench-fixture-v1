require_relative '../../automated_init'

context "Output" do
  context "Substitute" do
    context "Replay Records" do
      substitute = Fixture::Output::Substitute.build

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
        substitute.public_send(method_name, *arguments)
      end

      output = Fixture::Output::Substitute.build

      substitute.replay_records(output)

      test "All records are dispatched to given output" do
        assert(output.records == substitute.records)
      end
    end
  end
end
