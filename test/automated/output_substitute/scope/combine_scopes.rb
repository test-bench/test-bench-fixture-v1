require_relative '../../automated_init'

context "Output Substitute" do
  context "Scope" do
    context "Combine Scopes" do
      substitute = Fixture::Output::Substitute.build

      substitute.enter_context("Some Context")
      comment_1 = substitute.comment("Some comment")
      substitute.exit_context("Some Context", Controls::Result.example)

      substitute.enter_context("Other Context")
      comment_2 = substitute.comment("Some comment")
      substitute.exit_context("Other Context", Controls::Result.example)

      substitute.enter_context("Yet Another Context")
      comment_3 = substitute.comment("Some comment")
      substitute.exit_context("Yet Another Context", Controls::Result.example)

      scope_1 = substitute.scope("Some Context")
      scope_2 = substitute.scope("Other Context")

      scope = scope_1 + scope_2

      context "Match Records" do
        records = scope.match_records { |signal| signal == :comment }

        test "Considers records from both scopes" do
          assert(records == [comment_1, comment_2])
        end

        test "Does not consider records from outside either scope" do
          refute(records.include?(comment_3))
        end
      end
    end
  end
end
