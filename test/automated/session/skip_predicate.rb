require_relative '../automated_init'

context "Session" do
  context "Skip Predicate" do
    context "Skipped" do
      session = Fixture::Session.new

      session.skip!

      test do
        assert(session.skip? == true)
      end
    end

    context "Not Skipped" do
      session = Fixture::Session.new

      test do
        assert(session.skip? == false)
      end
    end
  end
end
