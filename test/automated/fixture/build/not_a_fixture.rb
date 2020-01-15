require_relative '../../automated_init'

context "Fixture" do
  context "Build" do
    context "Not a Fixture" do
      cls = Class.new do
        def call
        end
      end

      test "Is an error" do
        assert_raises(Fixture::Error) do
          Fixture.build(cls)
        end
      end
    end
  end
end
