require_relative '../automated_init'

context "Fixture" do
  context "Test" do
    fixture = Controls::Fixture.example

    title = "Some test"

    fixture.test(title) do
      #
    end

    test do
      assert(fixture.run.test?(title))
    end
  end
end
