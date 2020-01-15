require_relative '../../automated_init'

context "Fixture" do
  context "Factory Method" do
    context "Factory Method is Missing" do
      cls = Object.new

      test "Is an error" do
        assert_raises(Fixture::Error) do
          Fixture.factory_method(cls)
        end
      end
    end
  end
end
