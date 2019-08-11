require_relative '../automated_init'

context "Error Policy" do
  context "Policy Choice" do
    context "Default" do
      error_policy = Fixture::ErrorPolicy::Build.()

      test "Rescue assert" do
        assert(error_policy.instance_of?(Fixture::ErrorPolicy::RescueAssert))
      end
    end

    context "Abort" do
      error_policy = Fixture::ErrorPolicy::Build.(:abort)

      test do
        assert(error_policy.instance_of?(Fixture::ErrorPolicy::Abort))
      end
    end

    context "Raise" do
      error_policy = Fixture::ErrorPolicy::Build.(:raise)

      test do
        assert(error_policy.instance_of?(Fixture::ErrorPolicy::Raise))
      end
    end

    context "Rescue" do
      error_policy = Fixture::ErrorPolicy::Build.(:rescue)

      test do
        assert(error_policy.instance_of?(Fixture::ErrorPolicy::Rescue))
      end
    end

    context "Rescue Assert" do
      error_policy = Fixture::ErrorPolicy::Build.(:rescue_assert)

      test do
        assert(error_policy.instance_of?(Fixture::ErrorPolicy::RescueAssert))
      end
    end

    context "Unknown" do
      test "Raises error" do
        assert_raises Fixture::ErrorPolicy::Build::PolicyError do
          Fixture::ErrorPolicy::Build.(:unknown)
        end
      end
    end
  end
end
