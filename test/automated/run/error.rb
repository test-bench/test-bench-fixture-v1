require_relative '../automated_init'

context "Run" do
  context "Error" do
    run = Fixture::Run.new

    error = Controls::Error.example

    error_considered = false
    run.error_policy = proc { |e| error_considered = e == error }

    run.error(error)

    test "Outputs the error" do
      error_output = run.output.recorded_once?(:error) do |e|
        e == error
      end

      assert(error_output)
    end

    test "Increments error counter" do
      assert(run.error_counter == 1)
    end

    test "Error policy considers error" do
      assert(error_considered)
    end
  end
end
