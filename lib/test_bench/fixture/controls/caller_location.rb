module TestBench
  module Fixture
    module Controls
      module CallerLocation
        def self.example(file: nil, line_number: nil)
          file ||= self.file
          line_number ||= self.line_number

          eval(<<~RUBY, TOPLEVEL_BINDING, file, line_number - 2)
          some_class = Class.new do
            def self.some_method
              Thread.current.backtrace_locations[1]
            end
          end
          some_class.some_method
          RUBY
        end

        def self.file
          'lib/some_dir/some_file.rb'
        end

        def self.line_number
          11
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

            eval <<~RUBY, TOPLEVEL_BINDING, file, line_number
            proc { Thread.current.backtrace_locations[1] }.call
            RUBY
          end

          def self.file
            'test/some_dir/some_test_file.rb'
          end

          def self.line_number
            22
          end
        end
      end
    end
  end
end
