require_relative '../../../automated_init'

context "Session" do
  context "Substitute" do
    context "Test Failed Predicate" do
      substitute = Fixture::Session::Substitute.build

      substitute.instance_exec do
        test "Passing test" do
          #
        end

        test "Failing test 1" do
          assert(false)
        end

        test "Failing test 2" do
          assert(false)
        end

        test "Skipped test"
      end

      test "Failed" do
        assert(substitute.test_failed?(/Failing test/))
      end

      test "Passed" do
        refute(substitute.test_failed?("Passing test"))
      end

      test "Skipped" do
        refute(substitute.test_failed?("Skipped test"))
      end
    end
  end
end