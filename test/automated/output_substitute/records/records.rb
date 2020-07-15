require_relative '../../automated_init'

context "Output Substitute" do
  context "Records" do
    substitute = Fixture::Output::Substitute.build

    record_1 = substitute.comment("Comment #1")
    record_2 = substitute.comment("Comment #2")

    context "No Records Match" do
      records = substitute.records do |signal|
        signal != :comment
      end

      test "Empty" do
        assert(records.empty?)
      end
    end

    context "All Records Match" do
      records = substitute.records do |signal|
        signal == :comment
      end

      test "Detects all records" do
        assert(records == [record_1, record_2])
      end
    end

    context "Some Records Match" do
      records = substitute.records do |_, data|
        data == "Comment #2"
      end

      test "Detects matching records" do
        assert(records == [record_2])
      end
    end
  end
end
