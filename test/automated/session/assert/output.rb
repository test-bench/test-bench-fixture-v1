require_relative '../../automated_init'

context "Session" do
  context "Assert" do
    context "Output" do
      session = Fixture::Session.new

      result = session.assert(Object.new)

      test do
        assert_output = session.output.recorded_once?(:assert) do |r|
          result == true
        end

        assert(assert_output)
      end
    end
  end
end
