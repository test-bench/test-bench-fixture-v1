module TestBench
  module Fixture
    module Controls
      module CallerLocation
        def self.example(file: nil, line_number: nil, label: nil)
          file ||= self.file
          line_number ||= self.line_number
          label ||= self.label

          "#{file}:#{line_number}:in `#{label}'"
        end

        def self.file
          'lib/some_dir/some_file.rb'
        end

        def self.line_number
          11
        end

        def self.label
          'some_method'
        end

        module Alternate
          def self.example(line_number: nil)
            line_number ||= self.line_number

            CallerLocation.example(file: file, line_number: line_number)
          end

          def self.file
            'lib/other_dir/other_file.rb'
          end

          def self.line_number
            111
          end

          module Pattern
            def self.example
              /other_dir/
            end
          end
        end

        Implementation = self

        module Test
          def self.example(file: nil, line_number: nil)
            file ||= self.file
            line_number ||= self.line_number

            TOPLEVEL_BINDING.receiver.instance_eval 'proc { caller[0] }.call', file, line_number
          end

          def self.file
            'test/some_dir/some_test_file.rb'
          end

          def self.line_number
            22
          end

          def self.label
            'block in <main>'
          end
        end
      end
    end
  end
end
