module TestBench
  module Fixture
    module ErrorPolicy
      def self.configure(receiver, policy: nil, attr_name: nil)
        attr_name ||= :error_policy

        instance = Build.(policy)
        receiver.public_send(:"#{attr_name}=", instance)
        instance
      end

      module Build
        PolicyError = Class.new(RuntimeError)

        def self.call(policy=nil)
          cls = policy_class(policy)

          cls.new
        end

        def self.policy_class(policy=nil)
          policy ||= Defaults.policy

          policies.fetch(policy) do
            *policies, final_policy = self.policies.keys

            policy_list = "#{policies.map(&:inspect) * ', '} or #{final_policy.inspect}"

            raise PolicyError, "Policy #{policy.inspect} is unknown. It must be one of: #{policy_list}"
          end
        end

        def self.policies
          {
            :abort => Abort,
            :raise => Raise,
            :rescue => Rescue,
            :rescue_assert => RescueAssert
          }
        end

        module Defaults
          def self.policy
            :rescue_assert
          end
        end
      end

      class Abort
        def call(error)
          abort "TestBench is aborting (#{self.class})"
        end
      end

      class Raise
        def call(error)
          raise error
        end
      end

      class Rescue
        def call(error)
        end
      end

      class RescueAssert
        def call(error)
          unless error.instance_of?(AssertionFailure)
            raise error
          end
        end
      end
    end
  end
end
