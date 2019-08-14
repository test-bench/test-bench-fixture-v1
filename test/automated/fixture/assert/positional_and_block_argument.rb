require_relative '../../automated_init'

context "Fixture" do
  context "Comment" do
    context "Positional And Block Argument" do
      fixture = Controls::Fixture.example

      test "Raises error" do
        assert_raises ArgumentError do
          fixture.assert(true) { }
        end
      end
    end
  end
end
