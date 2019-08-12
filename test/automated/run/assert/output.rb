require_relative '../../automated_init'

context "Run" do
  context "Assert" do
    context "Output" do
      run = Fixture::Run.new

      result = run.assert(Object.new)

      test do
        assert_output = run.output.recorded_once?(:assert) do |r|
          result == true
        end

        assert(assert_output)
      end
    end
  end
end
