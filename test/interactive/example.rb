require_relative './interactive_init'

class ExampleFixture
  include Fixture

  def call
    context "Some Context" do
      context "Some Inner Context" do
        test "Some passing test" do
          assert(true)
        end

        test "Some failing test" do
          refute(true)
        end
      end

      test "Another passing test" do
        assert_raises RuntimeError do
          fail
        end
      end
    end
  end
end

Fixture.(ExampleFixture)
