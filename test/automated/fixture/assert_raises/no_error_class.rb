require_relative '../../automated_init'

context "Fixture" do
  context "Assert Raises" do
    context "No Error Class" do
      context "Pass" do
        fixture = Controls::Fixture.example

        error = Controls::Error.example

        fixture.assert_raises do
          raise error
        end

        test do
          refute(fixture.session.failed?)
        end
      end

      context "Failure" do
        fixture = Controls::Fixture.example

        begin
          fixture.assert_raises do
            #
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
