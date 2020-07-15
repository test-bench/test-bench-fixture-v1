require_relative '../../../automated_init'

context "Evaluate" do
  context "Block Argument" do
    context "Abort Error Policy" do
      session = Fixture::Session.new

      Fixture::ErrorPolicy.configure(session, policy: :abort)

      error = Controls::Error.example

      error_argument = :not_set

      begin
        result = session.evaluate(->{ raise error }) do |_, err|
          error_argument = err
        end
      rescue SystemExit => system_exit
      end

      refute(system_exit.nil?)

      test "Supplies the raised error to block" do
        assert(error_argument == error)
      end
    end
  end
end
