require_relative '../automated_init'

context "Session Substitute" do
  context "Asserted Predicate" do
    substitute = Fixture::Session::Substitute.build

    caller_location = Controls::CallerLocation.example

    result = Controls::Result.example

    substitute.context("Some Context") do
      substitute.assert(result, caller_location: caller_location)
    end

    context "Asserted" do
      context "With Arguments" do
        asserted = substitute.asserted?("Some Context", result: result, caller_location: caller_location)

        test do
          assert(asserted)
        end
      end

      context "With No Arguments" do
        asserted = substitute.asserted?

        test do
          assert(asserted)
        end
      end
    end

    context "Not Asserted" do
      context "Result Differs" do
        asserted = substitute.asserted?(result: !result)

        test do
          refute(asserted)
        end
      end

      context "Caller Location Differs" do
        other_caller_location = Controls::CallerLocation::Alternate.example

        asserted = substitute.asserted?(caller_location: other_caller_location)

        test do
          refute(asserted)
        end
      end

      context "Context Does Not Match" do
        asserted = substitute.asserted?("Other Context", result: result, caller_location: caller_location)

        test do
          refute(asserted)
        end
      end
    end
  end
end
