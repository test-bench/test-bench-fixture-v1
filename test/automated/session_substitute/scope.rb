require_relative '../automated_init'

context "Session Substitute" do
  context "Scope" do
    substitute = Fixture::Session::Substitute.build

    substitute.instance_exec do
      context "Some Context" do
        test "Some test" do
          assert(true)
        end
      end

      test "Some test" do
        assert(false)
      end
    end

    scope = substitute["Some Context"]

    scope_match = scope.one_test_passed?("Some test")

    test "Matches output data within the given scope" do
      assert(scope_match)
    end
  end
end
