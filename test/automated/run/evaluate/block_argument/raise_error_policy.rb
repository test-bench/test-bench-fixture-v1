require_relative '../../../automated_init'

context "Evaluate" do
  context "Block Argument" do
    context "Raise Error Policy" do
      run = Fixture::Run.new

      Fixture::ErrorPolicy.configure(run, policy: :raise)

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
