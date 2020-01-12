require_relative '../../automated_init'

context "Session" do
  context "Substitute" do
    context "One Pass" do
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

      context "One Test Matches" do
        test = substitute.one_pass("Some Context", "Passing test")

        test do
          assert(test == "Some Context\tPassing test")
        end
      end

      context "No Tests Match" do
        test = substitute.one_pass("Unknown test")

        test do
          assert(test.nil?)
        end
      end

      context "Multiple Tests Match" do
        test "Raises error" do
          assert_raises(Fixture::Session::Substitute::Session::Error) do
            substitute.one_pass("Passing test")
          end
        end
      end
    end
  end
end
