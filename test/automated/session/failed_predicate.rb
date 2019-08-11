require_relative '../automated_init'

context "Session" do
  context "Failed Predicate" do
    context "Failed" do
      session = Fixture::Session.new

      session.fail!

      test do
        assert(session.failed?)
      end
    end

    context "Not Failed" do
      session = Fixture::Session.new

      test do
        refute(session.failed?)
      end
    end
  end
end
