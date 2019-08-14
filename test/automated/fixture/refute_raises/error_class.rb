require_relative '../../automated_init'

context "Fixture" do
  context "Refute Raises" do
    context "Error Class" do
      error = Controls::Error.example

      context "Pass" do
        fixture = Controls::Fixture.example

        fixture.refute_raises(Controls::Error::Example) do
          #
        end

        test do
          refute(fixture.session.failed?)
        end
      end

      context "Failure" do
        context "Prohibited Error Raised" do
          fixture = Controls::Fixture.example

          begin
            fixture.refute_raises(Controls::Error::Example) do
              raise error
            end
          rescue Fixture::AssertionFailure
          end

          test do
            assert(fixture.session.failed?)
          end
        end

        context "Different Error Raised" do
          fixture = Controls::Fixture.example

          begin
            fixture.refute_raises(KeyError) do
              raise error
            end
          rescue Fixture::AssertionFailure
          rescue => raised_error
          end

          test "Error is raised" do
            refute(raised_error.nil?)
          end
        end
      end
    end
  end
end
