module TestBench
  module Fixture
    class Run
      module Substitute
        class Run
          class MatchTests
            include Output

            attr_reader :output_substitute
            attr_reader :patterns
            attr_reader :result

            def matches
              @matches ||= []
            end

            def stack
              @stack ||= []
            end

            def pattern_index
              @pattern_index ||= 0
            end
            attr_writer :pattern_index

            def initialize(output_substitute, result, *patterns)
              @output_substitute = output_substitute
              @result = result
              @patterns = patterns
            end

            def self.build(run, *patterns, result: nil)
              output_substitute = run.output

              patterns.map! do |pattern|
                if pattern.is_a?(String)
                  Regexp.new("\\A#{Regexp.escape(pattern)}\\z")
                else
                  pattern
                end
              end

              new(output_substitute, result, *patterns)
            end

            def self.call(run, *patterns, result: nil)
              instance = build(run, *patterns, result: result)
              instance.()
            end

            def call
              output_substitute.replay_records(self)

              matches
            end

            def enter_context(title)
              push(title)
            end

            def exit_context(_, _)
              pop
            end

            def finish_test(title, result)
              push(title)

              if match?(result)
                text = stack.join("\t")

                matches << text
              end

              pop
            end

            def skip_test(title)
              push(title)

              pop
            end

            def push(title)
              return if title.nil?

              if next_pattern.match?(title)
                self.pattern_index += 1
              end

              stack.push(title)
            end

            def pop
              title = stack.pop

              if previous_pattern.match?(title)
                self.pattern_index -= 1
              end
            end

            def match?(result)
              return false unless pattern_index == patterns.count

              if self.result.nil?
                true
              else
                result == self.result
              end
            end

            def next_pattern
              return Pattern.none if pattern_index == patterns.count

              patterns.fetch(pattern_index)
            end

            def previous_pattern
              return Pattern.none if pattern_index.zero?

              patterns[pattern_index - 1]
            end

            module Pattern
              def self.none
                %r{\z\A}
              end
            end
          end
        end
      end
    end
  end
end
