require_relative 'test_helper'

class PlayerTest < Test::Unit::TestCase
  def setup
    @player = Player.new
    @deck = Deck.new
    @dealer = Dealer.new
  end

  def test_player_can_get_hand_with_two_cards
    assert @player.empty_hand?
    @player.get_cards(@deck)
    assert_equal(2, @player.hand_count)
  end

  def test_player_can_see_what_card_the_dealer_is_showing
    king = Card.new(:clubs, :king, 10)
    two = Card.new(:clubs, :two, 2)
    three = Card.new(:clubs, :three, 3)
    @dealer.hand.cards = [king, two, three]
    assert_equal(5, @player.dealer_showing_hand_score(@dealer))
  end

  def test_player_can_win_blackjack
    ace = Card.new(:clubs, :ace, [11, 1])
    king = Card.new(:clubs, :king, 10)
    @player.hand.cards = [ace, king]
    assert(@player.blackjack?)
  end

  def test_player_can_bust
    king = Card.new(:clubs, :king, 10)
    queen = Card.new(:clubs, :queen, 10)
    two = Card.new(:clubs, :two, 2)
    @player.hand.cards = [king, queen, two]
    assert(@player.bust?)
  end
end
