require_relative '../../automated_init'

context "Fixture" do
  context "Comment" do
    fixture = Controls::Fixture.example

    text_1 = "Some comment"
    text_2 = "Other comment"
    text_3 = "Yet another comment"

    fixture.comment(text_1, text_2, text_3)

    [text_1, text_2, text_3].each do |text|
      context "Line: #{text}" do
        test do
          assert(fixture.session.commented?(text))
        end
      end
    end
  end
end
