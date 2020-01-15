require_relative '../../automated_init'

context "Fixture" do
  context "Detail" do
    fixture = Controls::Fixture.example

    text_1 = "Some detail"
    text_2 = "Other detail"
    text_3 = "Yet another detail"

    fixture.detail(text_1, text_2, text_3)

    [text_1, text_2, text_3].each do |text|
      context "Line: #{text}" do
        test do
          assert(fixture.session.detail?(text))
        end
      end
    end
  end
end
