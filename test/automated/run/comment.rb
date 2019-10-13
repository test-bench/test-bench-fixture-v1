require_relative '../automated_init'

context "Run" do
  context "Comment" do
    run = Fixture::Run.new

    text = "Some comment"

    run.comment(text)

    test "Outputs the comment" do
      comment_output = run.output.recorded_once?(:comment) do |t|
        t == text
      end

      assert(comment_output)
    end
  end
end
