require_relative '../automated_init'

context "Fixture" do
  context "Inspect" do
    fixture = Controls::Fixture.example

    original_test_session = fixture.test_session

    inspect_text = fixture.inspect

    context "Test Session Dependency" do
      test_session = fixture.test_session

      omitted = inspect_text.include?(<<~TEXT.chomp)
      @test_session="(not inspected; class is #{test_session.class})"
      TEXT

      test "Omitted from output" do
        assert(omitted)
      end

      test "Isn't changed" do
        assert(test_session.equal?(original_test_session))
      end
    end
  end
end
