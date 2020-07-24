require_relative '../automated_init'

context "Session" do
  context "Skip Predicate" do
    context "Skipped" do
      session = Fixture::Session.new

      session.record_skip

      test do
        assert(session.skipped? == true)
      end
    end

    context "Not Skipped" do
      session = Fixture::Session.new

      test do
        assert(session.skipped? == false)
      end
    end
  end
end
