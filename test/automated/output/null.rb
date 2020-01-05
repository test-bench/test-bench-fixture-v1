require_relative '../automated_init'

context "Output" do
  context "Null" do
    output = Fixture::Output::Null.new

    Controls::Output::Exercise.each_method do |method_name, args|
      context "Method: #{method_name}" do
        test "Does not raise an error" do
          refute_raises(NoMethodError) do
            output.public_send(method_name, *args)
          end
        end
      end
    end
  end
end
