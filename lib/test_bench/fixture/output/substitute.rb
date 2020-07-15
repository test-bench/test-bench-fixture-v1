module TestBench
  module Fixture
    module Output
      module Substitute
        def self.build
          Output.new
        end

        MatchError = Class.new(RuntimeError)

        class Output < Capture
          alias_method :raw_records, :records

          def scope(*contexts, &block)
            records = records(*contexts, &block)

            Scope.build(records)
          end

          def recorded_once?(*contexts, &block)
            record = one_record(*contexts, &block)

            record ? true : false
          end

          def recorded?(*contexts, &block)
            records = match_records(*contexts, &block)

            records.any?
          end

          def one_record(*contexts, &block)
            matching_records = match_records(*contexts, &block)

            return if matching_records.empty?

            unless matching_records.one?
              raise MatchError, "More than one records match"
            end

            matching_records.shift
          end

          def records(*contexts, &block)
            if contexts.empty? && block.nil?
              return raw_records
            end

            match_records(*contexts, &block)
          end

          def match_records(*contexts, &block)
            block ||= proc { true }

            raw_records.select do |record|
              context_iterator = record.context.to_enum

              contexts_match = contexts.all? do |context|
                until context_iterator.peek == context
                  context_iterator.next
                end
                true

              rescue StopIteration
                false
              end

              contexts_match &&
                block.(record.signal, *record.data, record.context)
            end
          end

          Fixture::Output.signals.each do |signal|
            signal_records_method = :"#{signal}_records" # e.g. comment_records
            define_method(signal_records_method) do |*contexts, &block|
              match_records(*contexts) do |recorded_signal, *data|
                if recorded_signal == signal
                  block.nil? || block.(*data)
                end
              end
            end

            one_signal_method = :"one_#{signal}_record" # e.g. one_comment_record
            define_method(one_signal_method) do |*contexts, &block|
              one_record(*contexts) do |recorded_signal, *data|
                if recorded_signal == signal
                  block.nil? || block.(*data)
                end
              end
            end

            signal_recorded_method = :"#{signal}_recorded?" # e.g. comment_recorded?
            define_method(signal_recorded_method) do |*contexts, &block|
              recorded?(*contexts) do |recorded_signal, *data|
                if recorded_signal == signal
                  block.nil? || block.(*data)
                end
              end
            end

            signal_recorded_once_method = :"#{signal}_recorded_once?" # e.g. comment_recorded_once?
            define_method(signal_recorded_once_method) do |*contexts, &block|
              recorded_once?(*contexts) do |recorded_signal, *data|
                if recorded_signal == signal
                  block.nil? || block.(*data)
                end
              end
            end
          end
        end
      end
    end
  end
end
