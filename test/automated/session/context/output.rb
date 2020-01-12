require_relative '../../automated_init'

context "Session" do
  context "Context" do
    context "Output" do
      title = "Some Context"

      context do
        session = Fixture::Session.new

        begin
          session.context(title) do
            fail
          end
        rescue RuntimeError
        end

        test "Enter context" do
          recorded = session.output.recorded_once?(:enter_context) do |t|
            t == title
          end

          assert(recorded)
        end

        test "Exit context" do
          recorded = session.output.recorded_once?(:exit_context) do |t, r|
            t == title && r == false
          end

          assert(recorded)
        end

        test "Skip context not recorded" do
          refute(session.output.recorded?(:skip_context))
        end
      end

      context "Skip" do
        session = Fixture::Session.new

        session.context(title)

        test "Skip context" do
          recorded = session.output.recorded_once?(:skip_context) do |t|
            t == title
          end

          assert(recorded)
        end

        test "Enter context not recorded" do
          refute(session.output.recorded?(:enter_context))
        end

        test "Exit context not recorded" do
          refute(session.output.recorded?(:exit_context))
        end
      end
    end
  end
end
