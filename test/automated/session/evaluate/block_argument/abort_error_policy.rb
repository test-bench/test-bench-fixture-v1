require_relative '../../../automated_init'

context "Evaluate" do
  context "Block Argument" do
    context "Abort Error Policy" do
      session = Fixture::Session.new

      Fixture::ErrorPolicy.configure(session, policy: :abort)

      error_argument = :not_set

      begin
        result = session.evaluate(->{ fail }) do |_, err|
          error_argument = err
        end
      rescue SystemExit => system_exit
      end

      refute(system_exit.nil?)

      test "Supplies the raised error to block" do
        assert(error_argument == system_exit)
      end
    end
  end
end
