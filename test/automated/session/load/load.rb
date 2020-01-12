require_relative '../../automated_init'

context "Session" do
  context "Load" do
    path = Controls::TestFile.example

    session = Fixture::Session.new

    result = session.load(path)

    context "Output" do
      test "Enter file" do
        recorded = session.output.recorded_once?(:enter_file) do |p|
          p == path
        end

        assert(recorded)
      end

      test "Exit file" do
        recorded = session.output.recorded_once?(:exit_file) do |p, r|
          p == path && r == result
        end

        assert(recorded)
      end
    end
  end
end
