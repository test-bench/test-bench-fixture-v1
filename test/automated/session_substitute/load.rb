require_relative '../automated_init'

context "Session Substitute" do
  context "Load" do
    path = Controls::TestFile.filename

    context "Loaded" do
      substitute = Fixture::Session::Substitute.build

      substitute.load(path)

      context "Path Given" do
        loaded = substitute.loaded?(path)

        test do
          assert(loaded)
        end
      end

      context "No Path Given" do
        loaded = substitute.loaded?

        test do
          assert(loaded)
        end
      end
    end

    context "Not Loaded" do
      context "Path Was Never Loaded" do
        substitute = Fixture::Session::Substitute.build

        loaded = substitute.loaded?

        test do
          refute(loaded)
        end
      end

      context "Path Differs" do
        substitute = Fixture::Session::Substitute.build

        substitute.load(Controls::TestFile::Alternate.filename)

        loaded = substitute.loaded?(path)

        test do
          refute(loaded)
        end
      end
    end
  end
end
