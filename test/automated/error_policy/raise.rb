require_relative '../automated_init'

context "Error Policy" do
  context "Raise" do
    error = Controls::Error.example

    error_policy = Fixture::ErrorPolicy::Raise.new

    test "Raises the error" do
      assert_raises(Controls::Error::Example) do
        error_policy.(error)
      end
    end
  end
end
