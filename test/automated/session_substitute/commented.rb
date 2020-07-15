require_relative '../automated_init'

context "Session Substitute" do
  context "Commented Predicate" do
    substitute = Fixture::Session::Substitute.build

    substitute.context("Some Context") do
      substitute.comment("Some comment")
    end

    context "Commented" do
      commented = substitute.commented?("Some Context", "Some comment")

      test do
        assert(commented)
      end
    end

    context "Not Commented" do
      context "Title Differs" do
        commented = substitute.commented?("Other comment")

        test do
          refute(commented)
        end
      end

      context "Context Does Not Match" do
        commented = substitute.commented?("Other Context", "Some comment")

        test do
          refute(commented)
        end
      end
    end
  end
end
