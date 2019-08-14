require_relative '../../automated_init'

context "Fixture" do
  context "Test" do
    title = "Some test"

    context "Pass" do
      fixture = Controls::Fixture.example

      fixture.test(title) do
        fixture.assert(true)
      end

      test "Test pass is recorded" do
        assert(fixture.session.test_passed?(title))
      end
    end

    context "Failure" do
      fixture = Controls::Fixture.example

      fixture.test(title) do
        fixture.assert(false)
      end

      test "Test failure is recorded" do
        assert(fixture.session.test_failed?(title))
      end
    end

    context "Skip" do
      fixture = Controls::Fixture.example

      fixture.test(title)

      ## Replace with test_skipped?(title)
      test "Test skip is recorded" do
        assert(fixture.session.output.skip_test_recorded_once? { |t| t == title })
      end
    end
  end
end
