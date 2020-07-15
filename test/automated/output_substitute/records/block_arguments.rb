require_relative '../../automated_init'

context "Output Substitute" do
  context "Records" do
    context "Block Arguments" do
      substitute = Fixture::Output::Substitute.build

      control_title = "Some test"
      control_result = Controls::Result.example
      control_context = "Some Context"

      substitute.current_context << control_context

      substitute.finish_test(control_title, control_result)

      block_arguments = nil

      substitute.records do |*args|
        block_arguments = args
      end

      context "Signal" do
        signal = block_arguments[0]

        test do
          assert(block_arguments[0] == :finish_test)
        end
      end

      context "Data" do
        title = block_arguments[1]
        result = block_arguments[2]

        test do
          assert(title == control_title && result == control_result)
        end
      end

      context "Context" do
        context = block_arguments[3]

        test do
          assert(context == [control_context])
        end
      end
    end
  end
end
