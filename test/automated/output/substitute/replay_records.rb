require_relative '../../automated_init'

context "Output" do
  context "Substitute" do
    context "Replay Records" do
      substitute = Fixture::Output::Substitute.build
      Controls::Output::Exercise.(substitute)

      output = Fixture::Output::Substitute.build

      substitute.replay_records(output)

      test "All records are dispatched to given output" do
        assert(output.records == substitute.records)
      end
    end
  end
end
