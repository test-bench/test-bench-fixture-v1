require_relative '../../../automated_init'

context "Session" do
  context "Substitute" do
    context "Test Passed Predicate" do
      context "No Arguments" do
        context "Passed" do
          context "All Tests Passed" do
            substitute = Fixture::Session::Substitute.build

            substitute.instance_exec do
              test "Some test" do
                #
              end
            end

            test do
              assert(substitute.test_passed?)
            end
          end

          context "Some Tests Passed" do
            substitute = Fixture::Session::Substitute.build

            substitute.instance_exec do
              test "Passing test" do
                #
              end

              test "Failing test" do
                assert(false)
              end
            end

            test do
              assert(substitute.test_passed?)
            end
          end
        end

        context "Not Passed" do
          substitute = Fixture::Session::Substitute.build

          substitute.instance_exec do
            test "Failing test" do
              assert(false)
            end
          end

          test do
            refute(substitute.test_passed?)
          end
        end
      end
    end
  end
end
