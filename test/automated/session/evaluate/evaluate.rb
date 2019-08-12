require_relative '../../automated_init'

context "Session" do
  context "Evaluate" do
    session = Fixture::Session.new

    block_executed = false

    block_argument = nil

    result = result = session.evaluate(->{ }) do |arg|
      block_executed = true

      block_argument = arg
    end

    test "Given block is executed" do
      assert(block_executed)
    end

    test "Result is supplied to block" do
      assert(block_argument == result)
    end
  end
end
