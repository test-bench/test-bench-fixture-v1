require_relative '../automated_init'

context "Session Substitute" do
  context "Detail Predicate" do
    substitute = Fixture::Session::Substitute.build

    substitute.context("Some Context") do
      substitute.detail("Some detail")
    end

    context "Detail Matched" do
      detail_matched = substitute.detail?("Some Context", "Some detail")

      test do
        assert(detail_matched)
      end
    end

    context "Detail Not Matched" do
      context "Title Differs" do
        detail_not_matched = substitute.detail?("Other detail")

        test do
          refute(detail_not_matched)
        end
      end

      context "Title Differs" do
        detail_not_matched = substitute.detail?("Other Context", "Some detail")

        test do
          refute(detail_not_matched)
        end
      end
    end
  end
end
