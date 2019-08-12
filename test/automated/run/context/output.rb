require_relative '../../automated_init'

context "Run" do
  context "Context" do
    context "Output" do
      title = "Some Context"

      context do
        run = Fixture::Run.new

        begin
          run.context(title) do
            fail
          end
        rescue RuntimeError
        end

        test "Enter context" do
          recorded = run.output.recorded_once?(:enter_context) do |t|
            t == title
          end

          assert(recorded)
        end

        test "Exit context" do
          recorded = run.output.recorded_once?(:exit_context) do |t, r|
            t == title && r == false
          end

          assert(recorded)
        end

        test "Skip context not recorded" do
          refute(run.output.recorded?(:skip_context))
        end
      end

      context "Skip" do
        run = Fixture::Run.new

        run.context(title)

        test "Skip context" do
          recorded = run.output.recorded_once?(:skip_context) do |t|
            t == title
          end

          assert(recorded)
        end

        test "Enter context not recorded" do
          refute(run.output.recorded?(:enter_context))
        end

        test "Exit context not recorded" do
          refute(run.output.recorded?(:exit_context))
        end
      end
    end
  end
end
