require_relative '../../automated_init'

context "Evaluate" do
  context "Failure" do
    context do
      session = Fixture::Session.new

      return_value = session.evaluate(->{
        session.fail!
      })

      test "Returns false" do
        assert(return_value == false)
      end
    end

    context "Assertion Failure" do
      session = Fixture::Session.new

      return_value = session.evaluate(->{
        session.assert(false)
      })

      test "Returns false" do
        assert(return_value == false)
      end
    end

    context "Error" do
      session = Fixture::Session.new

      Fixture::ErrorPolicy.configure(session, policy: :rescue)

      error = Controls::Error.example

      return_value = session.evaluate(->{
        raise error
      })

      test "Returns false" do
        assert(return_value == false)
      end

      test "Increments error counter" do
        assert(session.error_counter == 1)
      end
    end
  end
end
