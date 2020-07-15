require_relative '../automated_init'

context "Output" do
  context "Signals" do
    signals = Fixture::Output.signals

    Fixture::Controls::Output::Exercise.each_method do |signal, *|
      context "Signal: #{signal.inspect}" do
        included = signals.include?(signal)

        test "Included" do
          assert(included)
        end
      end
    end
  end
end
