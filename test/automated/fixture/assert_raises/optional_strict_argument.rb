require_relative '../../automated_init'

context "Fixture" do
  context "Assert Raises" do
    context "Optional Strict Argument" do
      error = Controls::Error.example

      context "Strict" do
        context "Subclass of Error Raised" do
          fixture = Controls::Fixture.example

          begin
            fixture.assert_raises(error.class.superclass, strict: true) do
              raise error
            end
          rescue error.class => raised_error
          end

          test "Not rescued" do
            refute(raised_error.nil?)
          end
        end
      end

      context "Non-Strict" do
        context "Subclass of Error Raised" do
          fixture = Controls::Fixture.example

          begin
            fixture.assert_raises(error.class.superclass, strict: false) do
              raise error
            end
          rescue error.class => raised_error
          end

          test "Rescued" do
            assert(raised_error.nil?)
          end
        end
      end
    end
  end
end
