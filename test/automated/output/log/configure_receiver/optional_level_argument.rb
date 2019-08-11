require_relative '../../../automated_init'

context "Output" do
  context "Log" do
    context "Configure Receiver" do
      context "Optional Level Argument" do
        context "Given" do
          {
            :unknown => Logger::Severity::UNKNOWN,
            :fatal => Logger::Severity::FATAL,
            :error => Logger::Severity::ERROR,
            :warning => Logger::Severity::WARN,
            :info => Logger::Severity::INFO,
            :debug => Logger::Severity::DEBUG
          }.each do |level, severity|
            context "Level: #{level.inspect}" do
              receiver = OpenStruct.new

              Fixture::Output::Log.configure(receiver, level: level)

              logger = receiver.output.logger

              test "Set to severity #{severity}" do
                assert(logger.level == severity)
              end
            end
          end

          context "Invalid Level" do
            level = Controls::Output::Log::Level::Invalid.example

            receiver = OpenStruct.new

            test "Is an error" do
              assert_raises(Fixture::Output::Log::Error) do
                Fixture::Output::Log.configure(receiver, level: level)
              end
            end
          end
        end

        context "Omitted" do
          receiver = OpenStruct.new

          Fixture::Output::Log.configure(receiver)

          logger = receiver.output.logger

          test "Set to debug severity" do
            assert(logger.level == Logger::DEBUG)
          end
        end
      end
    end
  end
end
