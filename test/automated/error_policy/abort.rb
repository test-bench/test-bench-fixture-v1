require_relative '../automated_init'

context "Error Policy" do
  context "Abort" do
    error = Controls::Error.example

    error_policy = Fixture::ErrorPolicy::Abort.new

    test "Exits the ruby process" do
      assert_raises SystemExit do
        error_policy.(error)
      end
    end
  end
end
