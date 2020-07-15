require_relative '../../automated_init'

context "Output Substitute" do
  context "One Record" do
    context "Context" do
      substitute = Fixture::Output::Substitute.build

      substitute.enter_context("Some Context")
      record_1 = substitute.comment("Comment #1")
      substitute.exit_context("Some Context", Controls::Result.example)

      record_2 = substitute.comment("Comment #2")

      record = substitute.one_record("Some Context") do |signal|
        signal == :comment
      end

      test "Matches the record inside the given context" do
        assert(record == record_1)
      end
    end
  end
end
