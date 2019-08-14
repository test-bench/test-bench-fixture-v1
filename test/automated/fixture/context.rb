require_relative '../automated_init'

context "Fixture" do
  context "Context" do
    fixture = Controls::Fixture.example

    title = "Some Context"

    fixture.context(title) do
      #
    end

    test do
      assert(fixture.run.context?(title))
    end
  end
end
