require_relative '../../automated_init'

context "Session" do
  context "Assert" do
    context "Output" do
      session = Fixture::Session.new

      result = session.assert(Object.new)

      test do
        assert_output = session.output.assert_recorded_once? do |r|
          r == result
        end

        assert(assert_output)
      end
    end
  end
end
