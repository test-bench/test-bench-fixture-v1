require_relative '../../automated_init'

context "Session" do
  context "Load" do
    path = Controls::TestFile.example

    session = Fixture::Session.new

    result = session.load(path)

    context "Output" do
      test "Enter file" do
        recorded = session.output.enter_file_recorded_once? do |p|
          p == path
        end

        assert(recorded)
      end

      test "Exit file" do
        recorded = session.output.exit_file_recorded_once? do |p, r|
          p == path && r == result
        end

        assert(recorded)
      end
    end
  end
end
