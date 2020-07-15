require_relative '../automated_init'

context "Session Substitute" do
  context "Fixture Predicate" do
    substitute = Fixture::Session::Substitute.build

    fixture = Controls::Fixture.example

    substitute.instance_exec do
      fixture(fixture) do
        assert(true)
      end
    end

    context "Fixture Was loaded" do
      test "Returns true" do
        assert(substitute.fixture?(fixture))
      end
    end

    context "Fixture Was Not Loaded" do
      other_fixture = Controls::Fixture.example

      test "Returns false" do
        refute(substitute.fixture?(other_fixture))
      end
    end
  end
end
