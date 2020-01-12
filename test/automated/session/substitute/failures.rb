require_relative '../../automated_init'

context "Session" do
  context "Substitute" do
    context "Failures" do
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

        test "Failing test" do
          assert(false)
        end
      end

      context "No Title Specified" do
        tests = substitute.failures

        test do
          assert(tests == [
            "Some Context\tFailing test",
            "Failing test"
          ])
        end
      end

      context "Title Specified" do
        tests = substitute.failures("Some Context")

        test do
          assert(tests == ["Some Context\tFailing test"])
        end
      end
    end
  end
end
