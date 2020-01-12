require_relative '../../../automated_init'

context "Session" do
  context "Substitute" do
    context "Load" do
      context "Failure" do
        substitute = Fixture::Session::Substitute.build

        substitute.load_failure!

        path = Controls::TestFile.filename

        result = substitute.load(path)

        test "Returns false" do
          assert(result == false)
        end

        test "Exit file record indicates success" do
          recorded = substitute.output.recorded_once?(:exit_file) do |_, r|
            r == result
          end

          assert(recorded)
        end
      end
    end
  end
end
