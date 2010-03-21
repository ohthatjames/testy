require 'rake/gempackagetask'

spec = Gem::Specification.new do |s| 
  s.name = "testy"
  s.version = "0.0.1"
  s.author = "James Hunt"
  s.email = "ohthatjames@googlemail.com"
  s.homepage = "http://github.com/ohthatjames/testy"
  s.platform = Gem::Platform::RUBY
  s.summary = "A very simple test framework"
  s.files = ["lib/testy.rb"]#FileList["{bin,lib}/**/*"].to_a
  s.require_path = "lib"
  s.test_files = FileList["{test}/**/*test.rb"].to_a + ["run_tests.rb"]
  s.has_rdoc = true
  s.extra_rdoc_files = ["README"]
end
 
Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end