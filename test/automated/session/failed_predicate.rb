require_relative '../automated_init'

context "Session" do
  context "Failed Predicate" do
    context "Failed" do
      session = Fixture::Session.new

      session.fail!

      test do
        assert(session.failed? == true)
      end
    end

    context "Not Failed" do
      session = Fixture::Session.new

      test do
        assert(session.failed? == false)
      end
    end
  end
end
