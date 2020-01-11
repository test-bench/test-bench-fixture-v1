require_relative '../../automated_init'

context "Session" do
  context "Finish" do
    context "Output" do
      context "Pass" do
        session = Fixture::Session.new

        session.finish

        test "Records the session finish to the output, indicating a passing result" do
          recorded = session.output.finish_recorded_once? do |result|
            result == true
          end

          assert(recorded)
        end
      end

      context "Failure" do
        session = Fixture::Session.new

        session.fail!

        session.finish

        test "Records the session finish to the output, indicating a failing result" do
          recorded = session.output.finish_recorded_once? do |result|
            result == false
          end

          assert(recorded)
        end
      end
    end
  end
end
