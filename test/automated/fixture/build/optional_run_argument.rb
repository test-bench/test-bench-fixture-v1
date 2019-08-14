require_relative '../../automated_init'

context "Fixture" do
  context "Build" do
    context "Optional Run Argument" do
      run = Fixture::Run.new 

      cls = Controls::Fixture::Example

      fixture = Fixture.build(cls, run: run)

      test "Supplies fixture with the given run" do
        assert(fixture.run.equal?(run))
      end
    end
  end
end
