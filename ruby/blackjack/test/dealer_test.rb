require_relative 'test_helper'

class DealerTest < Test::Unit::TestCase
  def setup
    @dealer = Dealer.new
    @player = Player.new 
    @two = Card.new(:clubs, :two, 2)
    @three = Card.new(:clubs, :three, 3)
    @eight = Card.new(:clubs, :eight, 8)
    @four = Card.new(:clubs, :four, 4)
  end

  def test_draw_until_seventeen
    deck = Deck.new
    deck.playable_cards = [@two, @three, @eight, @four]
    @dealer.get_cards(deck)
    refute(deck.playable_cards.empty?)
    @dealer.draw(deck)
    assert(deck.playable_cards.empty?)
    assert_equal(17, @dealer.hand_score)
  end
end
