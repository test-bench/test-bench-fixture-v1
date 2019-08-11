require_relative '../automated_init'

context "Session" do
  context "Comment" do
    session = Fixture::Session.new

    text = "Some comment"

    session.comment(text)

    test "Outputs the comment" do
      comment_output = session.output.comment_recorded_once? do |t|
        t == text
      end

      assert(comment_output)
    end
  end
end
