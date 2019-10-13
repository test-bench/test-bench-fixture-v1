require_relative '../../automated_init'

context "Evaluate" do
  context "Optional Block Argument" do
    run = Fixture::Run.new

    block_argument = nil

    begin
      run.evaluate(->{ fail }) do |arg|
        block_argument = arg
      end
    rescue RuntimeError
    end

    test "Given block is executed" do
      refute(block_argument.nil?)
    end

    test "Result of evaluation is supplied to block" do
      assert(block_argument == false)
    end
  end
end
