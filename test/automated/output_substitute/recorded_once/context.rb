require_relative '../../automated_init'

context "Output Substitute" do
  context "Recorded Once" do
    context "Context" do
      substitute = Fixture::Output::Substitute.build

      substitute.enter_context("Some Context")
      substitute.comment("Comment #1")
      substitute.exit_context("Some Context", Controls::Result.example)

      substitute.comment("Comment #2")

      recorded_once = substitute.recorded_once?("Some Context") do |signal|
        signal == :comment
      end

      test "Only considers records inside the given context" do
        assert(recorded_once)
      end
    end
  end
end
