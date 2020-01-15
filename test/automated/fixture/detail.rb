require_relative '../automated_init'

context "Fixture" do
  context "Detail" do
    fixture = Controls::Fixture.example

    text = "Some detail"

    fixture.detail(text)

    test do
      assert(fixture.session.detail?(text))
    end
  end
end
