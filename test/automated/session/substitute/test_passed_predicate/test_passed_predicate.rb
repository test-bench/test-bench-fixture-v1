require_relative '../../../automated_init'

context "Session" do
  context "Substitute" do
    context "Test Passed Predicate" do
      substitute = Fixture::Session::Substitute.build

      substitute.instance_exec do
        test "Passing test 1" do
          #
        end

        test "Passing test 2" do
          #
        end

        test "Failing test" do
          assert(false)
        end

        test "Skipped test"
      end

      test "Passed" do
        assert(substitute.test_passed?(/Passing test/))
      end

      test "Failed" do
        refute(substitute.test_passed?("Failing test"))
      end

      test "Skipped" do
        refute(substitute.test_passed?("Skipped test"))
      end
    end
  end
end
