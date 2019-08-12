require_relative '../../../automated_init'

context "Run" do
  context "Assert Block" do
    context "Failure" do
      context "Uncaught Error" do
        run = Fixture::Run.new

        begin
          run.assert_block do
            raise Controls::Error.example
          end
        rescue Controls::Error::Example => error
        end

        test do
          refute(error.nil?)
        end
      end
    end
  end
end
