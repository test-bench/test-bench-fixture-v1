require_relative '../../automated_init'

context "Output Substitute" do
  context "Scope" do
    substitute = Fixture::Output::Substitute.build

    substitute.enter_context("Outer Context")

    substitute.enter_context("Inner Context")

    record_1 = substitute.comment("Comment #1")
    record_2 = substitute.comment("Comment #2")

    substitute.exit_context("Inner Context", Controls::Result.example)

    substitute.exit_context("Outer Context", Controls::Result.example)

    scope = substitute.scope("Outer Context", "Inner Context")

    reduced = scope.records == [record_1, record_2]

    test "Reduced to the given context" do
      assert(reduced)
    end

    test "Original substitute is not modified" do
      not_modified = substitute.records.count > scope.records.count

      assert(not_modified)
    end
  end
end
