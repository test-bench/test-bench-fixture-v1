require_relative '../../automated_init'

context "Fixture" do
  context "Fixture (Instance Method)" do
    fixture = Controls::Fixture.example

    fixture_cls = Controls::Fixture::InstanceActuator::Example

    executed_fixture = fixture.fixture(fixture_cls)

    test "Returns a fixture instance of given class" do
      assert(executed_fixture.instance_of?(fixture_cls))
    end

    test "Sets run dependency to that of outer fixture" do
      assert(executed_fixture.run.equal?(fixture.run))
    end
  end
end
