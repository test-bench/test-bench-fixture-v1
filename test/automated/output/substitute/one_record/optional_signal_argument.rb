require_relative '../../../automated_init'

context "Output" do
  context "Substitute" do
    context "One Record" do
      context "Optional Signal Argument" do
        substitute = Fixture::Output::Substitute.build

        title = "Some test"
        result = Controls::Result.example

        record_1 = substitute.finish_test(title, result)
        record_2 = substitute.finish_test(title, !result)
        record_3 = substitute.skip_test(title)

        context "Exactly One Record Matches" do
          context "Optional Block Given" do
            matching_record = substitute.one_record(:finish_test) do |t, r|
              t == title && r == result
            end

            test "Returns the matching record" do
              assert(matching_record == record_1)
            end
          end

          context "Optional Block Omitted" do
            matching_record = substitute.one_record(:skip_test)

            test "Returns the matching record" do
              assert(matching_record == record_3)
            end
          end
        end

        context "No Record Matches" do
          context "Optional Block Given" do
            matching_record = substitute.one_record(:finish_test) do
              false
            end

            test "Returns nil" do
              assert(matching_record.nil?)
            end
          end

          context "Optional Block Omitted" do
            matching_record = substitute.one_record(:comment)

            test "Returns nil" do
              assert(matching_record.nil?)
            end
          end
        end

        context "Multiple Records Match" do
          test "Raises error" do
            assert_raises Fixture::Output::Substitute::MatchError do
              substitute.one_record(:finish_test) do
                true
              end
            end
          end
        end
      end
    end
  end
end
