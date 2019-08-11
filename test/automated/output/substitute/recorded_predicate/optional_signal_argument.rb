require_relative '../../../automated_init'

context "Output" do
  context "Substitute" do
    context "Recorded Predicate" do
      context "Optional Signal Argument" do
        substitute = Fixture::Output::Substitute.build

        title = "Some test"
        result = Controls::Result.example

        record_1 = substitute.finish_test(title, result)
        record_2 = substitute.finish_test(title, !result)
        record_3 = substitute.skip_test(title)

        context "Recorded" do
          context "Exactly One Record Matches" do
            context "Optional Block Given" do
              recorded = substitute.recorded?(:finish_test) do |t, r|
                t == title && r == result
              end

              test do
                assert(recorded == true)
              end
            end

            context "Optional Block Omitted" do
              recorded = substitute.recorded?(:skip_test)

              test "Returns the matching record" do
                assert(recorded == true)
              end
            end
          end

          context "Multiple Records Match" do
            recorded = substitute.recorded?(:finish_test) do
              true
            end

            test do
              assert(recorded == true)
            end
          end
        end

        context "No Record Matches" do
          recorded = substitute.recorded?(:finish_test) do
            false
          end

          test "Returns nil" do
            assert(recorded == false)
          end
        end
      end
    end
  end
end
