require_relative '../../automated_init'

context "Output Substitute" do
  context "Records" do
    context "Context" do
      substitute = Fixture::Output::Substitute.build

      substitute.enter_context("Outer Context")

      record_1 = substitute.comment("Comment #1")

      substitute.enter_context("Inner Context")
      record_2 = substitute.comment("Comment #2")
      record_3 = substitute.comment("Comment #3")
      substitute.exit_context("Inner Context", Controls::Result.example)

      record_4 = substitute.comment("Comment #4")

      substitute.exit_context("Outer Context", Controls::Result.example)

      record_5 = substitute.comment("Comment #5")

      context "Precise Context Match" do
        records = substitute.records("Outer Context", "Inner Context") do |signal|
          signal == :comment
        end

        matches = records == [record_2, record_3]

        test "Matches records from the context" do
          assert(matches)
        end
      end

      context "Outer Context Omitted" do
        records = substitute.records("Inner Context") do |signal|
          signal == :comment
        end

        matches = records == [record_2, record_3]

        test "Returns all records from matching inner context" do
          assert(matches)
        end
      end

      context "Multiple Contexts Match" do
        records = substitute.records("Outer Context") do |signal|
          signal == :comment
        end

        matches = records == [record_1, record_2, record_3, record_4]

        test "Returns all records from all matching contexts" do
          assert(matches)
        end
      end

      context "Contexts Are Out of Order" do
        records = substitute.records("Inner Context", "Outer Context") do |signal|
          signal == :comment
        end

        test "No records match" do
          assert(records.empty?)
        end
      end

      context "Block Omitted" do
        records = substitute.records("Outer Context", "Inner Context")

        matches = records.count == 2

        test "Matches all output signals within context" do
          assert(matches)
        end
      end

      context "Context Omitted" do
        records = substitute.records do |signal|
          signal == :comment
        end

        matches = records == [record_1, record_2, record_3, record_4, record_5]

        test "Matches all records, including those outside of contexts" do
          assert(matches)
        end
      end
    end
  end
end
