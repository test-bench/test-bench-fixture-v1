require_relative '../../../automated_init'

context "Session" do
  context "Evaluate" do
    context "Error" do
      context "Abort" do
        session = Fixture::Session.new

        error = Controls::Error.example

        error_considered = false
        session.error_policy = proc { |e| error_considered = e == error }

        return_value = session.evaluate(->{
          raise Fixture::Session::Abort
        })

        test "Doesn't output the Abort exception" do
          refute(session.output.error_recorded?)
        end

        test "Error policy doesn't consider the Abort exception" do
          refute(error_considered)
        end
      end
    end
  end
end
