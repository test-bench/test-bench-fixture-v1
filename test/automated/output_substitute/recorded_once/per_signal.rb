require_relative '../../automated_init'

context "Output Substitute" do
  context "Recorded Once" do
    context "Per Signal" do
      substitute = Fixture::Output::Substitute.build

      substitute.enter_context("Outer Context")

      Controls::Output::Exercise.each_method do |signal, args|
        context "Signal: #{signal}" do
          control_record = substitute.public_send(signal, *args)

          recorded_once_method = :"#{signal}_recorded_once?"

          context "Block Given" do
            recorded_once = substitute.public_send(recorded_once_method, "Outer Context") do |*data, _|
              data == args
            end

            test "Detects the matching record" do
              assert(recorded_once)
            end
          end

          context "Block Omitted" do
            recorded_once = substitute.public_send(recorded_once_method, "Outer Context")

            test "Detects the matching record" do
              assert(recorded_once)
            end
          end
        end
      end
    end
  end
end
