require_relative '../automated_init'

context "Fixture" do
  context "Test" do
    fixture = Controls::Fixture.example

    title = "Some test"

    fixture.test(title) do
      fixture.assert(true)
    end

    test do
      assert(fixture.session.test_passed?(title))
    end
  end
end
