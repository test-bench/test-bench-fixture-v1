require_relative '../../automated_init'

context "Session" do
  context "Assert" do
    context "Optional Caller Location Argument" do
      session = Fixture::Session.new

      context "Omitted" do
        begin
          file = __FILE__

          session.assert(false); line_number = __LINE__
        rescue Fixture::AssertionFailure => assertion_failure
        end

        test "Assertion backtrace refers to callsite" do
          pattern = "#{file}:#{line_number}"

          assert(assertion_failure.backtrace[0].include?(pattern))
        end
      end

      context "Given" do
        caller_location = Controls::CallerLocation.example

        begin
          session.assert(false, caller_location: caller_location)
        rescue Fixture::AssertionFailure => assertion_failure
        end

        test "Assertion backtrace refers to given caller location" do
          assert(assertion_failure.backtrace == [caller_location.to_s])
        end
      end
    end
  end
end
