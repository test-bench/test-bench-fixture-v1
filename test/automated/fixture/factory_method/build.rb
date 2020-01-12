require_relative '../../automated_init'

context "Fixture" do
  context "Factory Method" do
    context "Build Is Defined On Class" do
      cls = Controls::Fixture::FactoryMethod::Example

      factory_method = Fixture.factory_method(cls)

      test "Returns the build method" do
        assert(factory_method == cls.method(:build))
      end
    end
  end
end
