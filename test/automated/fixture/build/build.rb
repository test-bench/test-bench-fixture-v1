require_relative '../../automated_init'

context "Fixture" do
  context "Build" do
    cls = Controls::Fixture::Example

    fixture = Fixture.build(cls)

    test "Instantiates class" do
      assert(fixture.instance_of?(cls))
    end

    test "Configures run dependency" do
      refute(fixture.run.instance_of?(Fixture::Run::Substitute))
    end
  end
end
