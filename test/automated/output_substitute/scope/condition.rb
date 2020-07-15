require_relative '../../automated_init'

context "Output Substitute" do
  context "Scope" do
    context "Condition" do
      substitute = Fixture::Output::Substitute.build

      substitute.enter_context("Some Context")
      comment_1 = substitute.comment("Some comment")
      comment_2 = substitute.comment("Other comment")
      substitute.exit_context("Some Context", Controls::Result.example)

      scope = substitute.scope("Some Context") do |_, text|
        text == "Some comment"
      end

      test "Only includes records that satisfy the condition" do
        assert(scope.records == [comment_1])
      end
    end
  end
end
