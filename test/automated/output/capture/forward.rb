require_relative '../../automated_init'

context "Output" do
  context "Capture" do
    context "Forward" do
      capture_output = Fixture::Output::Capture.new

      receiver = Fixture::Output::Capture.new

      Controls::Output::Exercise.(capture_output)

      capture_output.each_record do |record|
        context "Forward Signal: #{record.signal.inspect}" do
          record.forward(receiver)

          forwarded = receiver.records.one? do |forwarded_record|
            forwarded_record == record
          end

          test "Forwards output record to the receiving output" do
            assert(forwarded)
          end
        end
      end
    end
  end
end
