require_relative '../../../automated_init'

context "Run" do
  context "Substitute" do
    context "Failed Predicate" do
      substitute = Fixture::Run::Substitute.build

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
        assert(substitute.failed?(/Failing test/))
      end

      test "Passed" do
        refute(substitute.failed?("Passing test"))
      end

      test "Skipped" do
        refute(substitute.failed?("Skipped test"))
      end
    end
  end
end
