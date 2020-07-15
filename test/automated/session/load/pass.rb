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

      context "Output Record" do
        test "Indicates success" do
          recorded = session.output.exit_file_recorded_once? do |f, r|
            f == path && r == true
          end

          assert(recorded)
        end
      end
    end
  end
end
