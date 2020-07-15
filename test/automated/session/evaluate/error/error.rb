require_relative '../../../automated_init'

context "Session" do
  context "Evaluate" do
    context "Error" do
      session = Fixture::Session.new

      error = Controls::Error.example

      error_considered = false
      session.error_policy = proc { |e| error_considered = e == error }

      session.evaluate(->{
        raise error
      })

      test "Increments failure counter" do
        assert(session.failure_counter == 1)
      end

      test "Outputs the error" do
        error_output = session.output.error_recorded_once? do |e|
          e == error
        end

        assert(error_output)
      end

      test "Error policy considers error" do
        assert(error_considered)
      end
    end
  end
end
