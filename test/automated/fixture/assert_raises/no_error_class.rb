require_relative '../../automated_init'

context "Fixture" do
  context "Assert Raises" do
    context "No Error Class" do
      context "Pass" do
        fixture = Controls::Fixture.example

        error = Controls::Error.example

        begin
          fixture.assert_raises do
            raise error
          end
        rescue Fixture::AssertionFailure => assertion_failure
        end

        test do
          assert(assertion_failure.nil?)
        end
      end

      context "Failure" do
        fixture = Controls::Fixture.example

        begin
          fixture.assert_raises do
            #
          end
        rescue Fixture::AssertionFailure => assertion_failure
        end

        test do
          refute(assertion_failure.nil?)
        end
      end
    end
  end
end
