require_relative '../../automated_init'

context "Output Substitute" do
  context "Records" do
    context "Per Signal" do
      substitute = Fixture::Output::Substitute.build

      substitute.enter_context("Outer Context")

      Controls::Output::Exercise.each_method do |signal, args|
        context "Signal: #{signal}" do
          control_record = substitute.public_send(signal, *args)

          records_method = :"#{signal}_records"

          context "Block Given" do
            records = substitute.public_send(records_method, "Outer Context") do |*data, _|
              data == args
            end

            test "Detects matching records of the given signal" do
              assert(records == [control_record])
            end
          end

          context "Block Omitted" do
            records = substitute.public_send(records_method, "Outer Context")

            test "Detects all records corresponding to the given signal" do
              assert(records == [control_record])
            end
          end
        end
      end
    end
  end
end
