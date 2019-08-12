require_relative '../../../automated_init'

context "Evaluate" do
  context "Block Argument" do
    context "Rescue Assert Error Policy" do
      context "Assertion Failure" do
        run = Fixture::Run.new

        Fixture::ErrorPolicy.configure(run, policy: :rescue_assert)

        error_argument = :not_set

        result = run.evaluate(->{ raise Fixture::AssertionFailure.build }) do |_, err|
          error_argument = err
        end

        test "Does not supply assertion failure to block" do
          assert(error_argument.nil?)
        end
      end

      context "Other Error" do
        run = Fixture::Run.new

        Fixture::ErrorPolicy.configure(run, policy: :rescue_assert)

        error_argument = :not_set

        begin
          result = run.evaluate(->{ fail }) do |_, err|
            error_argument = err
          end
        rescue => error
        end

        refute(error.nil?)

        test "Supplies the raised error to block" do
          assert(error_argument == error)
        end
      end
    end
  end
end
