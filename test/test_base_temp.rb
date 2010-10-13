class TestBaseTemp < Test::Unit::TestCase
  def test_base_temp_determined_by_month
    assert_equal(BaselineData.new.month(3).temperature, 42, "Base temperature of Coldeven is 42")
    assert_equal(BaselineData.new.month(6).temperature, 71, "Base temperature of Wealsun is 71")
    assert_equal(BaselineData.new.month(9).temperature, 68, "Base temperature of Harvester is 68")
  end
end
