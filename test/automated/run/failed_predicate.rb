require_relative '../automated_init'

context "Run" do
  context "Failed Predicate" do
    context "Failed" do
      run = Fixture::Run.new

      run.error_counter = 11

      test do
        assert(run.failed?)
      end
    end

    context "Not Failed" do
      run = Fixture::Run.new

      run.error_counter = 0

      test do
        refute(run.failed?)
      end
    end
  end
end
