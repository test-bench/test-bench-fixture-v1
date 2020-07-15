require_relative '../automated_init'

context "Session" do
  context "Detail" do
    session = Fixture::Session.new

    text = "Some detail"

    session.detail(text)

    test "Outputs the detail" do
      detail_output = session.output.detail_recorded_once? do |t|
        t == text
      end

      assert(detail_output)
    end
  end
end
