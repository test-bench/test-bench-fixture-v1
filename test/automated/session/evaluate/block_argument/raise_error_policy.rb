require_relative '../../../automated_init'

context "Evaluate" do
  context "Block Argument" do
    context "Raise Error Policy" do
      session = Fixture::Session.new

      Fixture::ErrorPolicy.configure(session, policy: :raise)

      error_argument = :not_set

      begin
        result = session.evaluate(->{ fail }) do |_, err|
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
