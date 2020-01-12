require_relative '../../../automated_init'

context "Session" do
  context "Substitute" do
    context "Load" do
      substitute = Fixture::Session::Substitute.build

      path = Controls::TestFile.filename

      result = substitute.load(path)

      test "Enter file is recorded" do
        recorded = substitute.output.recorded_once?(:enter_file) do |p|
          p == path
        end

        assert(recorded)
      end

      test "Exit file is recorded" do
        recorded = substitute.output.recorded_once?(:exit_file) do |p, r|
          p == path && r == result
        end

        assert(recorded)
      end
    end
  end
end
