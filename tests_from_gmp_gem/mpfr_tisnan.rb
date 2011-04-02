require_relative 'test_helper'

class MPFR_ISNAN < Test::Unit::TestCase
  def setup
    @rand_state = GMP::RandState.new
    @one = GMP::F(1)
    @zero = GMP::F(0)
    @inf = @one/@zero
    @neg_one = GMP::F(-1)
    @neg_inf = @neg_one/@zero
    @nan = @neg_inf - @neg_inf
    @neg_zero = GMP::F("-0")
  end

  def test_nan
    assert_false(@inf.nan?, "@inf.nan? should be false")
    assert_false(@neg_inf.nan?, "@neg_inf.nan? should be false")
    assert(@nan.nan?, "@nan.nan? should be true")
    assert_false(@one.nan?, "@one.nan? should be false")
    assert_false(@zero.nan?, "@zero.nan? should be false")
    assert_false(@neg_zero.nan?, "@neg_zero.nan? should be false")
  end

  def test_infinite
    assert(@inf.infinite?, "@inf.infinite? should be true")
    assert(@neg_inf.infinite?, "@neg_inf.infinite? should be true")
    assert_false(@nan.infinite?, "@nan.infinite? should be false")
    assert_false(@one.infinite?, "@one.infinite? should be false")
    assert_false(@zero.infinite?, "@zero.infinite? should be false")
    assert_false(@neg_zero.infinite?, "@neg_zero.infinite? should be false")
  end

  def test_finite
    assert_false(@inf.finite?, "@inf.finite? should be false")
    assert_false(@neg_inf.finite?, "@neg_inf.finite? should be false")
    #assert(@nan.finite?, "@nan.finite? should be true")  // eh...
    assert(@one.finite?, "@one.finite? should be true")
    assert(@zero.finite?, "@zero.finite? should be true")
    assert(@neg_zero.finite?, "@neg_zero.finite? should be true")
  end

  def test_number
    assert_false(@inf.number?, "@inf.number? should be false")
    assert_false(@neg_inf.number?, "@neg_inf.number? should be false")
    assert_false(@nan.number?, "@nan.number? should be false")
    assert(@one.number?, "@one.number? should be true")
    assert(@zero.number?, "@zero.number? should be true")
    assert(@neg_zero.number?, "@neg_zero.number? should be true")
  end

  def test_zero
    assert_false(@inf.zero?, "@inf.zero? should be false")
    assert_false(@neg_inf.zero?, "@neg_inf.zero? should be false")
    assert_false(@nan.zero?, "@nan.zero? should be false")
    assert_false(@one.zero?, "@one.zero? should be false")
    assert(@zero.zero?, "@zero.zero? should be true")
    assert(@neg_zero.zero?, "@neg_zero.zero? should be true")
  end

  def test_regular
    if GMP::MPFR_VERSION >= "3.0.0"
      assert_false(@inf.regular?, "@inf.regular? should be false")
      assert_false(@neg_inf.regular?, "@neg_inf.regular? should be false")
      assert_false(@nan.regular?, "@nan.regular? should be false")
      assert(@one.regular?, "@one.regular? should be true")
      assert_false(@zero.regular?, "@zero.regular? should be false")
      assert_false(@neg_zero.regular?, "@neg_zero.regular? should be false")
    end
  end
end
