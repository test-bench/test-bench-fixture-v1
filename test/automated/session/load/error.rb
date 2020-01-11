require_relative '../../automated_init'

context "Session" do
  context "Load" do
    context "Error" do
      path = Controls::TestFile::Failure.example

      session = Fixture::Session.new

      Fixture::ErrorPolicy.configure(session, policy: :rescue)

      test "Not rescued by session" do
        assert_raises(Controls::Error::Example) do
          session.load(path)
        end
      end

      context "Output Record" do
        test "Indicates failure" do
          recorded = session.output.exit_file_recorded_once? do |f, r|
            f == path && r == false
          end

          assert(recorded)
        end
      end
    end
  end
end
