require_relative '../../automated_init'

context "Session" do
  context "Substitute" do
    context "Passes" do
      substitute = Fixture::Session::Substitute.build

      substitute.instance_exec do
        context "Some Context" do
          test "Passing test" do
            #
          end

          test "Failing test" do
            assert(false)
          end
        end

        test "Passing test" do
          #
        end
      end

      context "No Title Specified" do
        tests = substitute.passes

        test do
          assert(tests == [
            "Some Context\tPassing test",
            "Passing test"
          ])
        end
      end

      context "Title Specified" do
        tests = substitute.passes("Some Context")

        test do
          assert(tests == ["Some Context\tPassing test"])
        end
      end
    end
  end
end
