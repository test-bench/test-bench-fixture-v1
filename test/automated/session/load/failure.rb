require_relative '../../automated_init'

context "Session" do
  context "Load" do
    context "Failure" do
      path = Controls::TestFile::Failure.example

      session = Fixture::Session.new

      Fixture::ErrorPolicy.configure(session, policy: :rescue)

      return_value = session.load(path)

      test "Returns false" do
        assert(return_value == false)
      end
    end
  end
end
