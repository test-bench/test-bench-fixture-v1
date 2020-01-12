require_relative '../../automated_init'

context "Fixture" do
  context "Build" do
    context "Factory Method" do
      context "No Arguments" do
        cls = Controls::Fixture::FactoryMethod::Example

        fixture = Fixture.build(cls)

        test "Instantiates class" do
          assert(fixture.instance_of?(cls))
        end

        test "Calls build method" do
          assert(fixture.build_method_called?)
        end
      end

      context "Arguments" do
        cls = Controls::Fixture::ConstructorArguments::FactoryMethod::Example

        blk = proc { }

        fixture = Fixture.build(cls, 'arg1', 'arg2', arg3: 'arg3', arg4: 'arg4', &blk)

        test "Instantiates class" do
          assert(fixture.instance_of?(cls))
        end

        context "Attributes" do
          [:arg1, :arg2, :arg3, :arg4].each do |attribute|
            value = fixture.public_send(attribute)

            test "#{attribute} (#{value.inspect})" do
              assert(value == attribute.to_s)
            end
          end
        end

        test "Block argument" do
          assert(fixture.blk == blk)
        end
      end
    end
  end
end
