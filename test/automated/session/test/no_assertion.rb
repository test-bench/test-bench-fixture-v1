require_relative '../../automated_init'

context "Session" do
  context "Test" do
    context "No Assertion" do
      session = Fixture::Session.new

      test "Is an error" do
        assert_raises(Fixture::Session::Error) do
          session.test do
            #
          end
        end
      end
    end
  end
end
