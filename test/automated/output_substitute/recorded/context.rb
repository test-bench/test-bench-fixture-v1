require_relative '../../automated_init'

context "Output Substitute" do
  context "Recorded" do
    context "Context" do
      substitute = Fixture::Output::Substitute.build

      substitute.enter_context("Some Context")
      substitute.comment("Comment #1")
      substitute.exit_context("Some Context", Controls::Result.example)

      context "Given Context Contains a Record" do
        recorded = substitute.recorded?("Some Context") do |signal|
          signal == :comment
        end

        test "Recorded" do
          assert(recorded)
        end
      end

      context "Given Context Does Not Contain a Record" do
        recorded = substitute.recorded?("Other Context") do |signal|
          signal == :comment
        end

        test "Not Recorded" do
          refute(recorded)
        end
      end
    end
  end
end
