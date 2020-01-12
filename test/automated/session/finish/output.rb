require_relative '../../automated_init'

context "Session" do
  context "Finish" do
    context "Output" do
      context "Pass" do
        session = Fixture::Session.new

        session.finish

        test "Records the session finish to the output, indicating a passing result" do
          recorded = session.output.recorded_once?(:finish) do |(result)|
            result == true
          end

          assert(recorded)
        end
      end

      context "Failure" do
        session = Fixture::Session.new

        session.error_counter = 1

        session.finish

        test "Records the session finish to the output, indicating a failing result" do
          recorded = session.output.recorded_once?(:finish) do |(result)|
            result == false
          end

          assert(recorded)
        end
      end
    end
  end
end
