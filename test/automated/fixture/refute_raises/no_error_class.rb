require_relative '../../automated_init'

context "Fixture" do
  context "Refute Raises" do
    context "No Error Class" do
      context "Pass" do
        fixture = Controls::Fixture.example

        begin
          fixture.refute_raises do
            #
          end
        rescue Fixture::AssertionFailure => assertion_failure
        end

        test do
          assert(assertion_failure.nil?)
        end
      end

      context "Failure" do
        error = Controls::Error.example

        fixture = Controls::Fixture.example

        begin
          fixture.refute_raises do
            raise error
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
