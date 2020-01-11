require_relative '../../automated_init'

context "Output" do
  context "Substitute" do
    substitute = Fixture::Output::Substitute.build

    Controls::Output::Exercise.(substitute) do |method_name, args|
      context "Method: #{method_name}" do
        test "Records method invocation" do
          recorded_invocation = substitute.records.one? do |record|
            record.signal == method_name && record.data == args
          end

          assert(recorded_invocation)
        end
      end
    end
  end
end
