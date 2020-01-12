require_relative '../../automated_init'

context "Session" do
  context "Load" do
    context "Pass" do
      path = Controls::TestFile::Pass.example

      session = Fixture::Session.new

      return_value = session.load(path)

      test "Returns true" do
        assert(return_value == true)
      end
    end
  end
end
