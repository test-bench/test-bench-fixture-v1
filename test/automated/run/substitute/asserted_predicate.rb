require_relative '../../automated_init'

context "Run" do
  context "Substitute" do
    context "Asserted Predicate" do
      context "Assertion" do
        substitute = Fixture::Run::Substitute.build

        result = Controls::Result.example

        caller_location = Controls::CallerLocation.example

        substitute.assert(result, caller_location: caller_location)

        context "No Arguments Given" do
          test "Returns true" do
            assert(substitute.asserted? == true)
          end
        end

        context "Result Matches" do
          test "Returns true" do
            assert(substitute.asserted?(result) == true)
          end
        end

        context "Result Does Not Match" do
          test "Returns false" do
            assert(substitute.asserted?(!result) == false)
          end
        end

        context "Caller Location Matches" do
          test "Returns true" do
            assert(substitute.asserted?(caller_location: caller_location) == true)
          end
        end

        context "Caller Location Does Not Match" do
          test "Returns false" do
            assert(substitute.asserted?(caller_location: caller_locations.first) == false)
          end
        end
      end

      context "No Assertion" do
        substitute = Fixture::Run::Substitute.build

        test "Returns false" do
          assert(substitute.asserted? == false)
        end
      end
    end
  end
end
