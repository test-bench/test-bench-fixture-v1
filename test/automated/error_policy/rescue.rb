require_relative '../automated_init'

context "Error Policy" do
  context "Rescue" do
    error = Controls::Error.example

    error_policy = Fixture::ErrorPolicy::Rescue.new

    test "Does not raise the error" do
      refute_raises(Controls::Error::Example) do
        error_policy.(error)
      end
    end
  end
end
