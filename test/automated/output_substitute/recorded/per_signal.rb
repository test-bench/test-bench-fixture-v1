require_relative '../../automated_init'

context "Output Substitute" do
  context "Recorded" do
    context "Per Signal" do
      substitute = Fixture::Output::Substitute.build

      substitute.enter_context("Outer Context")

      Controls::Output::Exercise.each_method do |signal, args|
        context "Signal: #{signal}" do
          control_record = substitute.public_send(signal, *args)

          recorded_method = :"#{signal}_recorded?"

          context "Block Given" do
            recorded = substitute.public_send(recorded_method, "Outer Context") do |*data, _|
              data == args
            end

            test "Detects the matching record" do
              assert(recorded)
            end
          end

          context "Block Omitted" do
            recorded = substitute.public_send(recorded_method, "Outer Context")

            test "Detects the matching record" do
              assert(recorded)
            end
          end
        end
      end
    end
  end
end
