module TestBench
  module Fixture
    module Controls
      module TestFile
        def self.example(filename: nil, text: nil, directory: nil)
          filename ||= self.filename
          text ||= self.text
          directory ||= self.directory

          basename, extension, _ = filename.partition('.rb')

          file = Tempfile.new([basename, extension], directory)
          file.write(text)
          file.close

          tempfiles << file

          file.path
        end

        def self.filename
          'some_test_file.rb'
        end

        def self.path
          "test/automated/#{filename}"
        end

        def self.text
          '# Nothing'
        end

        def self.directory
          '/tmp'
        end

        def self.tempfiles
          @tempfiles ||= []
        end

        module Alternate
          def self.example
            TestFile.example(filename: filename)
          end

          def self.filename
            'other_test_file.rb'
          end
        end

        module Pass
          def self.example(directory: nil)
            TestFile.example(filename: filename, directory: directory)
          end

          def self.filename
            'some_passing_test.rb'
          end
        end

        module Failure
          def self.example(directory: nil)
            TestFile.example(text: text, filename: filename, directory: directory)
          end

          def self.filename
            'some_failing_test.rb'
          end

          def self.text
            "raise #{Error.name}.example"
          end
        end
      end
    end
  end
end
