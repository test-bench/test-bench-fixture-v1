require_relative '../../automated_init'

context "Output Substitute" do
  context "Recorded Once" do
    substitute = Fixture::Output::Substitute.build

    title = "Some test"
    result = Controls::Result.example

    record_1 = substitute.finish_test(title, result)
    record_2 = substitute.finish_test(title, !result)

    context "Exactly One Record Matches" do
      recorded = substitute.recorded_once? do |signal, t, r|
        signal == :finish_test && t == title && r == result
      end

      test "Returns true" do
        assert(recorded == true)
      end
    end

    context "No Record Matches" do
      recorded = substitute.recorded_once? do
        false
      end

      test "Returns false" do
        assert(recorded == false)
      end
    end

    context "Multiple Records Match" do
      test "Raises error" do
        assert_raises(Fixture::Output::Substitute::MatchError) do
          substitute.recorded_once? do
            true
          end
        end
      end
    end
  end
end
