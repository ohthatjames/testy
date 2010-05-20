class TestThis < Testy::TestSuite
  
  def setup
    @variable = true
  end
  
  def test_passes
    assert(true)
  end
  
  def test_fails
    assert(false)
    puts "This line should not be run"
  end
  
  def test_setup_works
    assert(@variable)
  end
  
  def test_catches_error
    raise Exception
    puts "This line should not be run"
  end
  
  def test_pending
    pending
    puts "This line should not be run"
  end
  
  def test_equal
    assert_equal("Hi", "Hi")
  end
  
  def test_not_equal
    assert_equal("Hi", "Bye")
  end
end