module Testy
  class AssertionFailure < Exception
    def initialize(expected, got)
      @expected, @got = expected, got
    end
  
    def message
      "Expected: #{@expected}, got: #{@got}"
    end
  end
  
  class PendingTestException < Exception
    
  end

  class TestSuite
  
    def self.inherited(klass)
      @@registered_suites ||= []
      @@registered_suites << klass
    end
  
    def self.registered_suites
      @@registered_suites ||= []
      @@registered_suites
    end
  
    def setup
    end
  
    def assert(assertion)
      raise AssertionFailure.new(true, assertion) unless assertion
    end
    
    def pending
      raise PendingTestException
    end
  end
  
  class TestResult
    attr_accessor :suite, :method
    def initialize(suite, method)
      @suite, @method = suite, method
    end
    
    def print(num)
      puts "#{num}) #{suite.to_s}##{method}"
    end
  end

  class TestFailure < TestResult
    attr_accessor :failure
    def initialize(suite, method, failure)
      super(suite, method)
      @failure = failure
    end
  
    def print(num)
      super
      puts "  #{@failure.message}" 
      puts @failure.backtrace.map {|line| "  #{line}"}.join("\n")
    end
  end
  
  class TestPending < TestResult
    
  end

  class TestSuiteRunner
    def initialize(suites)
      @suites = suites
      @test_case_count = 0
      @failures = []
      @pendings = []
    end
  
    def run
      @suites.each do |suite|
        run_suite(suite)
      end
      puts
      print_failures
      print_pendings
      print_summary
    end
  
    def run_suite(suite)
      suite.instance_methods.select {|method| method =~ /^test_/}.each do |method|
        @test_case_count += 1
        test = suite.new
        begin
          test.setup
          test.send(method)
          print "."
        rescue PendingTestException => p
          @pendings << TestPending.new(suite, method)
        rescue Exception => e
          print 'F'
          @failures << TestFailure.new(suite, method, e)
        end
        STDOUT.flush
      end
    end
    
    private
    def print_failures
      print_section("Failures", @failures)
    end
    
    def print_pendings
      print_section("Pending", @pendings)
    end
    
    def print_section(name, collection)
      return if collection.empty?
      puts "\n\n#{name}:"
      collection.each_with_index do |item, idx|
        item.print(idx + 1)
        puts
      end
    end
    
    def print_summary
      puts "\n#{@test_case_count} tests, #{@failures.size} failures, #{@pendings.size} pending"
    end
  end

  class TestRunner
    
    def initialize(directory)
      load_files_from(directory)
    end
    
    def run
      suites = TestSuite.registered_suites
      TestSuiteRunner.new(suites).run
    end
    
    private
    def load_files_from(directory)
      Dir["#{directory}/*"].each {|file| require file}
    end
  end
end