require_relative '../../automated_init'

context "Run" do
  context "Substitute" do
    context "Pass" do
      substitute = Fixture::Run::Substitute.build

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

      test = substitute.pass("Passing test")

      test do
        assert(test == "Some Context\tPassing test")
      end
    end
  end
end
