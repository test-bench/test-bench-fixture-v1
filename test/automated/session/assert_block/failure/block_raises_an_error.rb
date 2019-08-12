require_relative '../../../automated_init'

context "Session" do
  context "Assert Block" do
    context "Failure" do
      context "Block Raises an Error" do
        session = Fixture::Session.new

        begin
          session.assert_block do
            raise Controls::Error.example
          end
        rescue Controls::Error::Example => error
        end

        test "Error is not rescued" do
          refute(error.nil?)
        end

        test "Output indicates assert block failed" do
          assert_block_failed = session.output.recorded_once?(:exit_assert_block) do |_, r|
            r == false
          end

          assert(assert_block_failed)
        end
      end
    end
  end
end
