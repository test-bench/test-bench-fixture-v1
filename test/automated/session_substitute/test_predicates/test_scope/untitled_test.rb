require_relative '../../../automated_init'

context "Session Substitute" do
  context "Test Predicates" do
    context "Test Scope" do
      context "Untitled Test" do
        substitute = Fixture::Session::Substitute.build

        substitute.instance_exec do
          context "Some Test" do
            test do
              assert(false)
            end
          end

          context "Other Test" do
            test do
              assert(true)
            end
          end
        end

        test_scope = substitute.test_scope("Some Test")

        context "Test Is Inside A Matching Context" do
          in_scope = test_scope.finish_test_recorded_once? do |title, *, context|
            title.nil? && context == ["Some Test"]
          end

          test "In scope" do
            assert(in_scope)
          end
        end

        context "Test Is Outside A Matching Context" do
          in_scope = test_scope.finish_test_recorded_once? do |title, *, context|
            title.nil? && context == ["Other Test"]
          end

          test "Not in scope" do
            refute(in_scope)
          end
        end
      end
    end
  end
end
