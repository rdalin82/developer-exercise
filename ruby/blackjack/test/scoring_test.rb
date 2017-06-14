require_relative "test_helper"

class Klass
  include Scoring
end

class ScoringTest < Test::Unit::TestCase
  def setup
    @deck = Deck.new
    @hand = Hand.new
    @mock = Klass.new
  end

  def test_two_aces
    ace_one = Card.new(:clubs, :ace, [11, 1])
    ace_two = Card.new(:spades, :ace, [11, 1])
    @hand.cards = [ace_one, ace_two]
    assert_equal(12, @mock.score(@hand))
  end

  def test_blackjack
    ace = Card.new(:clubs, :ace, [11, 1])
    king = Card.new(:clubs, :king, 10)
    @hand.cards = [ace, king]
    assert_equal(21, @mock.score(@hand))
  end

  def test_basic_hand
    king = Card.new(:clubs, :king, 10)
    king_too = Card.new(:spades, :king, 10)
    @hand.cards = [king, king_too]
    assert_equal(20, @mock.score(@hand))
  end

  def test_bust_hand
    king = Card.new(:clubs, :king, 10)
    jack = Card.new(:clubs, :jack, 10)
    queen = Card.new(:clubs, :queen, 10)
    @hand.cards = [king, jack, queen]
    assert_equal(30, @mock.score(@hand))
  end

  def test_three_ace_hand
    ace_one = Card.new(:hearts, :ace, [11, 1])
    ace_two = Card.new(:clubs, :ace, [11, 1])
    ace_three = Card.new(:spades, :ace, [11, 1])
    @hand.cards = [ace_one, ace_two, ace_three]
    assert_equal(13, @mock.score(@hand))
  end
end
