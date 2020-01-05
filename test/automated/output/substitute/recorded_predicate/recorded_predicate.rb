require_relative '../../../automated_init'

context "Output" do
  context "Substitute" do
    context "Recorded Predicate" do
      substitute = Fixture::Output::Substitute.build

      title = "Some test"
      result = Controls::Result.example

      record_1 = substitute.finish_test(title, result)
      record_2 = substitute.finish_test(title, !result)

      context "Recorded" do
        context "Exactly One Record Matches" do
          recorded = substitute.recorded? do |signal, t, r|
            signal == :finish_test && t == title && r == result
          end

          test do
            assert(recorded == true)
          end
        end

        context "Multiple Records Match" do
          test do
            assert_raises(Fixture::Output::Substitute::MatchError) do
              substitute.one_record do
                true
              end
            end
          end
        end
      end

      context "Not Recorded" do
        recorded = substitute.recorded? do
          false
        end

        test do
          assert(recorded == false)
        end
      end
    end
  end
end
