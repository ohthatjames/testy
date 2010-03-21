require File.join(File.dirname(__FILE__), 'lib', 'testy')

Testy::TestRunner.new(File.join(File.dirname(__FILE__), 'test')).run