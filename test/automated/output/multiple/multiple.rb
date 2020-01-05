require_relative '../../automated_init'

context "Output" do
  context "Multiple" do
    multiple = Fixture::Output::Multiple.new

    context "Two Outputs Are Registered" do
      output_1 = Fixture::Output::Substitute.build
      output_2 = Fixture::Output::Substitute.build

      multiple.outputs = [output_1, output_2]

      Controls::Output::Exercise.(multiple) do |method_name, args|
        context "Method: #{method_name}" do
          test "Forwarded to first output" do
            forwarded = output_1.recorded_once?(method_name) do |*a|
              a == args
            end

            assert(forwarded)
          end

          test "Forwarded to second output" do
            forwarded = output_1.recorded_once?(method_name) do |*a|
              a == args
            end

            assert(forwarded)
          end
        end
      end
    end
  end
end
