require_relative '../../automated_init'

context "Fixture" do
  context "Comment" do
    fixture = Controls::Fixture.example

    text = "Some comment"

    fixture.comment(text)

    test do
      assert(fixture.session.commented?(text))
    end
  end
end
