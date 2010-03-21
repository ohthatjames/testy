class TestThat < Testy::TestSuite
  
  def test_passes
    assert(true)
  end
  
  def test_fails
    assert(false)
    puts "This line should not be run"
  end
end