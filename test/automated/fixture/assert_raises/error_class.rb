require_relative '../../automated_init'

context "Fixture" do
  context "Assert Raises" do
    context "Error Class" do
      error = Controls::Error.example

      context "Pass" do
        fixture = Controls::Fixture.example

        begin
          fixture.assert_raises(Controls::Error::Example) do
            raise error
          end
        rescue Fixture::AssertionFailure => assertion_failure
        end

        test do
          assert(assertion_failure.nil?)
        end
      end

      context "Failure" do
        context "No Error Raised" do
          fixture = Controls::Fixture.example

          begin
            fixture.assert_raises(Controls::Error::Example) do
              #
            end
          rescue Fixture::AssertionFailure => assertion_failure
          end

          test do
            refute(assertion_failure.nil?)
          end
        end

        context "Different Error Raised" do
          fixture = Controls::Fixture.example

          begin
            fixture.assert_raises(KeyError) do
              raise error
            end
          rescue Fixture::AssertionFailure => assertion_failure
          rescue error.class => raised_error
          end

          test "Not rescued" do
            assert(assertion_failure.nil?)
            refute(raised_error.nil?)
          end
        end
      end
    end
  end
end
