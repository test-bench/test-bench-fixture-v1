require_relative '../../../automated_init'

context "Evaluate" do
  context "Block Argument" do
    context "Rescue Error Policy" do
      session = Fixture::Session.new

      Fixture::ErrorPolicy.configure(session, policy: :rescue)

      error_argument = :not_set

      result = session.evaluate(->{ fail }) do |_, err|
        error_argument = err
      end

      test "Does not supply raised error to block" do
        assert(error_argument.nil?)
      end
    end
  end
end
