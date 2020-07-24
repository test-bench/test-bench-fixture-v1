require_relative '../automated_init'

context "Fixture" do
  context "Context" do
    fixture = Controls::Fixture.example

    title = "Some Context"

    fixture.context(title) do
      #
    end

    context_recorded = fixture.session.output.exit_context_recorded? do |t|
      t == title
    end

    test do
      assert(context_recorded)
    end
  end
end
