require_relative '../../../automated_init'

context "Output" do
  context "Log" do
    context "Configure Receiver" do
      context "Optional Attribute Name Argument" do
        context "Given" do
          receiver = OpenStruct.new

          Fixture::Output::Log.configure(receiver, attr_name: :some_attr)

          test "Configures the given attribute on receiver" do
            refute(receiver.some_attr.nil?)
          end
        end

        context "Omitted" do
          receiver = OpenStruct.new

          Fixture::Output::Log.configure(receiver)

          test "Configures the output on receiver" do
            refute(receiver.output.nil?)
          end
        end
      end
    end
  end
end
