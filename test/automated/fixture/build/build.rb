require_relative '../../automated_init'

context "Fixture" do
  context "Build" do
    cls = Controls::Fixture::Example

    fixture = Fixture.build(cls)

    test "Instantiates class" do
      assert(fixture.instance_of?(cls))
    end

    test "Configures session dependency" do
      refute(fixture.session.instance_of?(Fixture::Session::Substitute))
    end
  end
end
