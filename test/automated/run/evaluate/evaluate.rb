require_relative '../../automated_init'

context "Evaluate" do
  context "Pass" do
    run = Fixture::Run.new

    return_value = run.evaluate(->{})

    test "Returns true" do
      assert(return_value == true)
    end
  end

  context "Failure" do
    context "Assertion Failure" do
      run = Fixture::Run.new

      return_value = run.evaluate(->{
        run.assert(false)
      })

      test "Returns false" do
        assert(return_value == false)
      end
    end

    context "Error" do
      run = Fixture::Run.new

      Fixture::ErrorPolicy.configure(run, policy: :rescue)

      error = Controls::Error.example

      return_value = run.evaluate(->{
        raise error
      })

      test "Returns false" do
        assert(return_value == false)
      end

      test "Increments error counter" do
        assert(run.error_counter == 1)
      end
    end
  end
end
