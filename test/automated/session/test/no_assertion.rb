require_relative '../../automated_init'

context "Session" do
  context "Test" do
    context "No Assertion" do
      context do
        session = Fixture::Session.new

        test "Is an error" do
          assert_raises(Fixture::Session::Error) do
            session.test do
              #
            end
          end
        end
      end

      context "Failure Is Recorded By Block" do
        session = Fixture::Session.new

        test "Isn't an error" do
          refute_raises(Fixture::Session::Error) do
            session.test do
              session.record_failure
            end
          end
        end
      end
    end
  end
end
