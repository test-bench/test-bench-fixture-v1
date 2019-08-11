require_relative '../../automated_init'

context "Error Policy" do
  context "Configure Receiver" do
    context "Optional Attribute Name Argument" do
      context "Omitted" do
        receiver = Struct.new(:error_policy).new

        Fixture::ErrorPolicy.configure(receiver)

        test "Sets error policy attribute on receiver" do
          refute(receiver.error_policy.nil?)
        end
      end

      context "Given" do
        receiver = Struct.new(:some_attr).new

        Fixture::ErrorPolicy.configure(receiver, attr_name: :some_attr)

        test "Sets given attribute on receiver" do
          refute(receiver.some_attr.nil?)
        end
      end
    end
  end
end
