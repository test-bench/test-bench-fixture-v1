require_relative '../automated_init'

context "Fixture" do
  context "Fixture (Instance Method)" do
    outer_fixture = Controls::Fixture.example

    fixture_cls = Controls::Fixture::Example

    executed_fixture = outer_fixture.fixture(fixture_cls)

    test "Returns a fixture instance of given class" do
      assert(executed_fixture.instance_of?(fixture_cls))
    end

    test "Sets session dependency to that of outer fixture" do
      assert(executed_fixture.session.equal?(outer_fixture.session))
    end
  end
end
