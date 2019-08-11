require_relative '../../../automated_init'

context "Output" do
  context "Substitute" do
    context "Recorded Once Predicate" do
      context "Optional Signal Argument" do
        substitute = Fixture::Output::Substitute.build

        title = "Some test"
        result = Controls::Result.example

        record_1 = substitute.finish_test(title, result)
        record_2 = substitute.finish_test(title, !result)
        record_3 = substitute.skip_test(title)

        context "Exactly One Record Matches" do
          context "Optional Block Given" do
            recorded = substitute.recorded_once?(:finish_test) do |t, r|
              t == title && r == result
            end

            test "Returns true" do
              assert(recorded)
            end
          end

          context "Optional Block Omitted" do
            recorded = substitute.recorded_once?(:skip_test)

            test "Returns true" do
              assert(recorded == true)
            end
          end
        end

        context "No Record Matches" do
          context "Optional Block Given" do
            recorded = substitute.recorded_once?(:finish_test) do
              false
            end

            test "Returns false" do
              assert(recorded == false)
            end
          end

          context "Optional Block Omitted" do
            recorded = substitute.recorded_once?(:comment)

            test "Returns false" do
              assert(recorded == false)
            end
          end
        end

        context "Multiple Records Match" do
          test "Raises error" do
            assert_raises Fixture::Output::Substitute::MatchError do
              substitute.recorded_once?(:finish_test) do
                true
              end
            end
          end
        end
      end
    end
  end
end
