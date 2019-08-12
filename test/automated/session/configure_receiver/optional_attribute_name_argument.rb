require_relative '../../automated_init'

context "Session" do
  context "Configure Receiver" do
    context "Optional Attribute Name Argument" do
      context "Omitted" do
        receiver = Struct.new(:session).new

        Fixture::Session.configure(receiver)

        test "Sets session attribute on receiver" do
          refute(receiver.session.nil?)
        end
      end

      context "Given" do
        receiver = Struct.new(:some_attr).new

        Fixture::Session.configure(receiver, attr_name: :some_attr)

        test "Sets given attribute on receiver" do
          refute(receiver.some_attr.nil?)
        end
      end
    end
  end
end
