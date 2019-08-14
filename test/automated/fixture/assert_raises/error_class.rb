require_relative '../../automated_init'

context "Fixture" do
  context "Assert Raises" do
    context "Error Class" do
      error = Controls::Error.example

      context "Pass" do
        fixture = Controls::Fixture.example

        fixture.assert_raises(Controls::Error::Example) do
          raise error
        end

        test do
          refute(fixture.run.failed?)
        end
      end

      context "Failure" do
        context "No Error Raised" do
          fixture = Controls::Fixture.example

          begin
            fixture.assert_raises(Controls::Error::Example) do
              #
            end
          rescue Fixture::AssertionFailure
          end

          test do
            assert(fixture.run.failed?)
          end
        end

        context "Different Error Raised" do
          fixture = Controls::Fixture.example

          begin
            fixture.assert_raises(KeyError) do
              raise error
            end
          rescue error.class => raised_error
          end

          test "Not rescued" do
            refute(raised_error.nil?)
          end
        end
      end
    end
  end
end
