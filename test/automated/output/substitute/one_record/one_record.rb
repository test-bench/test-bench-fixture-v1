require_relative '../../../automated_init'

context "Output" do
  context "Substitute" do
    context "One Record" do
      substitute = Fixture::Output::Substitute.build

      title = "Some test"
      result = Controls::Result.example

      record_1 = substitute.finish_test(title, result)
      record_2 = substitute.finish_test(title, !result)

      context "Exactly One Record Matches" do
        matching_record = substitute.one_record do |signal, t, r|
          signal == :finish_test && t == title && r == result
        end

        test "Returns the matching record" do
          assert(matching_record == record_1)
        end
      end

      context "No Record Matches" do
        matching_record = substitute.one_record do
          false
        end

        test "Returns nil" do
          assert(matching_record.nil?)
        end
      end

      context "Multiple Records Match" do
        test "Raises error" do
          assert_raises(Fixture::Output::Substitute::MatchError) do
            substitute.one_record do
              true
            end
          end
        end
      end
    end
  end
end
