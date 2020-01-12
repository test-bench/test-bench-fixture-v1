require_relative '../../automated_init'

context "Fixture" do
  context "Factory Method" do
    context "Build Is Defined On Class" do
      cls = Controls::Fixture::Example

      factory_method = Fixture.factory_method(cls)

      test "Returns the default constructor" do
        assert(factory_method == cls.method(:new))
      end
    end
  end
end
