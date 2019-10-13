require_relative '../../automated_init'

context "Run" do
  context "Configure Receiver" do
    context "Optional Attribute Name Argument" do
      context "Omitted" do
        receiver = Struct.new(:run).new

        Fixture::Run.configure(receiver)

        test "Sets run attribute on receiver" do
          refute(receiver.run.nil?)
        end
      end

      context "Given" do
        receiver = Struct.new(:some_attr).new

        Fixture::Run.configure(receiver, attr_name: :some_attr)

        test "Sets given attribute on receiver" do
          refute(receiver.some_attr.nil?)
        end
      end
    end
  end
end
