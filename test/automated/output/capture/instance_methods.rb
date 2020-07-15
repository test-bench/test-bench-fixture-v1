require_relative '../../automated_init'

context "Output" do
  context "Capture" do
    context "Instance Methods" do
      capture_output = Fixture::Output::Capture.new

      Controls::Output::Exercise.(capture_output) do |method_name, args|
        context "Method: #{method_name}" do
          test "Records method invocation" do
            recorded_invocation = capture_output.records.one? do |record|
              record.signal == method_name && record.data == args
            end

            assert(recorded_invocation)
          end
        end
      end
    end
  end
end
