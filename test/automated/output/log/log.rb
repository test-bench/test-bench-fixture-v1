require_relative '../../automated_init'

context "Output" do
  context "Log" do
    log_output = Fixture::Output::Log.build

    Controls::Output::Exercise.(log_output)
  end
end
