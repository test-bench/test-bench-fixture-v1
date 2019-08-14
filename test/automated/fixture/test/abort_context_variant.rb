require_relative '../../automated_init'

context "Fixture" do
  context "Test" do
    context "Abort Context Variant" do
      title = "Some test"

      context "Pass" do
        fixture = Controls::Fixture.example

        begin
          fixture.test!(title) do
            fixture.assert(true)
          end
        rescue Fixture::Session::AbortContext => abort_context
        end

        test "Abort Context error isn't raised" do
          assert(abort_context.nil?)
        end

        test "Test pass is recorded" do
          assert(fixture.session.test_passed?(title))
        end
      end

      context "Failure" do
        fixture = Controls::Fixture.example

        begin
          fixture.test!(title) do
            fixture.assert(false)
          end
        rescue Fixture::Session::AbortContext => abort_context
        end

        test "Abort Context error is raised" do
          refute(abort_context.nil?)
        end

        test "Test failure is recorded" do
          assert(fixture.session.test_failed?(title))
        end
      end

      context "Skip" do
        fixture = Controls::Fixture.example

        begin
          fixture.test!(title)
        rescue Fixture::Session::AbortContext => abort_context
        end

        test "Abort Context error is raised" do
          refute(abort_context.nil?)
        end

        ## Replace with test_skipped?(title)
        test "Test skip is recorded" do
          assert(fixture.session.output.skip_test_recorded_once? { |t| t == title })
        end
      end
    end
  end
end
