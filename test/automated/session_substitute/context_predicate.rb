require_relative '../automated_init'

context "Session Substitute" do
  context "Context Predicate" do
    substitute = Fixture::Session::Substitute.build

    substitute.instance_exec do
      context "Some Context" do
        #
      end

      context "Other Context" do
        comment "Some Context"
      end
    end

    context "Given Context Executed" do
      context_executed = substitute.context?("Some Context")

      test do
        assert(context_executed)
      end
    end

    context "Given Context Did Not Execute" do
      context "No Context" do
        context_executed = substitute.context?("Yet Another Context")

        test do
          refute(context_executed)
        end
      end

      context "Context Title Matches Another Output Signal's Title" do
        context_executed = substitute.context?("Other Context", "Some Context")

        test do
          refute(context_executed)
        end
      end
    end
  end
end
