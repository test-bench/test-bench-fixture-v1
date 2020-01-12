require_relative '../../automated_init'

context "Fixture" do
  context "Build" do
    context "Optional Error Policy Argument" do
      cls = Controls::Fixture::Example

      fixture = Fixture.build(cls, error_policy: :abort)

      test "Configures the given error policy" do
        assert(fixture.session.error_policy.instance_of?(Fixture::ErrorPolicy::Abort))
      end
    end
  end
end
