require_relative '../../../automated_init'

context "Run" do
  context "Substitute" do
    context "Match Tests" do
      substitute = Fixture::Run::Substitute.build

      substitute.instance_exec do
        (1..3).each do |index|
          context "Example Context ##{index}" do
            test "Some test" do
              #
            end
          end
        end

        test "Other test" do
          #
        end
      end

      tests = substitute.match_tests("Some test")

      test do
        assert(tests == [
          "Example Context #1\tSome test",
          "Example Context #2\tSome test",
          "Example Context #3\tSome test"
        ])
      end
    end
  end
end
