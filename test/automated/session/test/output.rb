require_relative '../../automated_init'

context "Session" do
  context "Test" do
    context "Output" do
      title = "Some test"

      context do
        session = Fixture::Session.new

        begin
          session.test(title) do
            fail
          end
        rescue RuntimeError
        end

        test "Start test" do
          recorded = session.output.recorded_once?(:start_test) do |t|
            t == title
          end

          assert(recorded)
        end

        test "Finish test" do
          recorded = session.output.recorded_once?(:finish_test) do |t, r|
            t == title && r == false
          end

          assert(recorded)
        end

        test "Skip test not recorded" do
          refute(session.output.recorded?(:skip_test))
        end
      end

      context "Skip" do
        session = Fixture::Session.new

        session.test(title)

        test "Skip test" do
          recorded = session.output.recorded_once?(:skip_test) do |t|
            t == title
          end

          assert(recorded)
        end

        test "Start test not recorded" do
          refute(session.output.recorded?(:start_test))
        end

        test "Finish test not recorded" do
          refute(session.output.recorded?(:finish_test))
        end
      end
    end
  end
end
