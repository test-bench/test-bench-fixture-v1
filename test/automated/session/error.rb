require_relative '../automated_init'

context "Session" do
  context "Error" do
    session = Fixture::Session.new

    error = Controls::Error.example

    error_considered = false
    session.error_policy = proc { |e| error_considered = e == error }

    session.error(error)

    test "Outputs the error" do
      error_output = session.output.error_recorded_once? do |e|
        e == error
      end

      assert(error_output)
    end

    test "Increments error counter" do
      assert(session.error_counter == 1)
    end

    test "Error policy considers error" do
      assert(error_considered)
    end
  end
end
