require_relative '../../automated_init'

context "Session" do
  context "Substitute" do
    context "Failure" do
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

      test = substitute.failure("Failing test")

      test do
        assert(test == "Some Context\tFailing test")
      end
    end
  end
end
