require_relative '../../../automated_init'

context "Session" do
  context "Substitute" do
    context "Failed Predicate" do
      context "No Arguments" do
        context "Failed" do
          context do
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
              assert(substitute.failed?)
            end
          end

          context "No Tests Failed" do
            substitute = Fixture::Session::Substitute.build

            begin
              substitute.instance_exec do
                assert(false)
              end
            rescue Fixture::AssertionFailure
            end

            test do
              assert(substitute.failed?)
            end
          end
        end

        context "Not Failed" do
          substitute = Fixture::Session::Substitute.build

          substitute.instance_exec do
            test "Some test" do
              #
            end
          end

          test do
            refute(substitute.failed?)
          end
        end
      end
    end
  end
end
