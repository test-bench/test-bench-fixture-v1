# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'test_bench-fixture'
  s.version = '2.0.0.pre1'

  s.authors = ['Nathan Ladd']
  s.email = 'nathanladd+github@gmail.com'
  s.homepage = 'https://github.com/test-bench/test-bench-fixture'
  s.licenses = %w(MIT)
  s.summary = "Test object framework"
  s.platform = Gem::Platform::RUBY

  s.require_paths = %w(lib)
  s.files = Dir.glob 'lib/**/*'

  s.add_development_dependency 'test_bench-bootstrap'
end
