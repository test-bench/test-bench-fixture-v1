require_relative '../../../automated_init'

context "Session" do
  context "Evaluate" do
    context "Error Policies" do
      context "Rescue Error Policy" do
        session = Fixture::Session.new

        Fixture::ErrorPolicy.configure(session, policy: :rescue)

        error_argument = :not_nil

        result = session.evaluate(->{ fail }) do |_, err|
          error_argument = err
        end

        test "Does not supply raised error to block" do
          assert(error_argument.nil?)
        end
      end
    end
  end
end
