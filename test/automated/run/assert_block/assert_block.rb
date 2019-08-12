require_relative '../../automated_init'

context "Run" do
  context "Assert Block" do
    context "Pass" do
      run = Fixture::Run.new

      test "Does not raise an assertion failure" do
        refute_raises(Fixture::AssertionFailure) do
          run.assert_block do
            run.assert(true)
          end
        end
      end
    end

    context "Failure" do
      context "Assertion Failure" do
        run = Fixture::Run.new

        test "Raises an assertion failure" do
          assert_raises(Fixture::AssertionFailure) do
            run.assert_block do
              run.assert(false)
            end
          end
        end
      end

      context "No Assertion Made By Block" do
        run = Fixture::Run.new

        test "Raises an assertion failure" do
          assert_raises(Fixture::AssertionFailure) do
            run.assert_block do
              #
            end
          end
        end
      end

      context "Block Breaks Before Assertion" do
        run = Fixture::Run.new

        test "Raises an assertion failure" do
          assert_raises(Fixture::AssertionFailure) do
            run.assert_block do
              break
              run.assert(true)
            end
          end
        end
      end

      context "Error" do
        context "Rescue Error Policy" do
          run = Fixture::Run.new

          Fixture::ErrorPolicy.configure(run, policy: :rescue)

          error = Controls::Error.example

          test "Raises an assertion failure" do
            assert_raises(Fixture::AssertionFailure) do
              run.assert_block do
                raise error
              end
            end
          end
        end

        context "Raise Error Policy" do
          run = Fixture::Run.new

          Fixture::ErrorPolicy.configure(run, policy: :raise)

          error = Controls::Error.example

          test "Error is re-raised" do
            assert_raises(error.class) do
              run.assert_block do
                raise error
              end
            end
          end
        end
      end
    end
  end
end
