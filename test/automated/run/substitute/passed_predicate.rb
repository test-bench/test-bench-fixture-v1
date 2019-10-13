require_relative '../../automated_init'

context "Run" do
  context "Substitute" do
    context "Passed Predicate" do
      substitute = Fixture::Run::Substitute.build

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
        assert(substitute.passed?(/Passing test/))
      end

      test "Failed" do
        refute(substitute.passed?("Failing test"))
      end

      test "Skipped" do
        refute(substitute.passed?("Skipped test"))
      end
    end
  end
end
