require_relative '../../automated_init'

context "Output Substitute" do
  context "Records" do
    context "Per Signal" do
      substitute = Fixture::Output::Substitute.build

      substitute.enter_context("Outer Context")

      Controls::Output::Exercise.each_method do |signal, args|
        context "Signal: #{signal}" do
          control_record = substitute.public_send(signal, *args)

          one_record_method = :"one_#{signal}_record"

          context "Block Given" do
            record = substitute.public_send(one_record_method, "Outer Context") do |*data, _|
              data == args
            end

            test "Detects the matching record" do
              assert(record == control_record)
            end
          end

          context "Block Omitted" do
            record = substitute.public_send(one_record_method, "Outer Context")

            test "Detects the matching record" do
              assert(record == control_record)
            end
          end
        end
      end
    end
  end
end
