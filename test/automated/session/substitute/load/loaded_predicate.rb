require_relative '../../../automated_init'

context "Session" do
  context "Substitute" do
    context "Load" do
      context "Loaded Predicate" do
        substitute = Fixture::Session::Substitute.build

        path = Controls::TestFile.filename

        substitute.load(path)

        context "Path Was loaded" do
          test "Returns true" do
            assert(substitute.loaded?(path))
          end
        end

        context "Path Was Not Loaded" do
          other_path = Controls::TestFile::Alternate.example

          test "Returns false" do
            refute(substitute.loaded?(other_path))
          end
        end
      end
    end
  end
end
