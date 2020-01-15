require_relative '../../automated_init'

context "Fixture" do
  context "Refute Raises" do
    context "No Error Class" do
      context "Pass" do
        fixture = Controls::Fixture.example

        fixture.refute_raises do
          #
        end

        test do
          refute(fixture.session.failed?)
        end
      end

      context "Failure" do
        error = Controls::Error.example

        fixture = Controls::Fixture.example

        begin
          fixture.refute_raises do
            raise error
          end
        rescue Fixture::AssertionFailure
        end

        test do
          assert(fixture.session.failed?)
        end
      end
    end
  end
end
