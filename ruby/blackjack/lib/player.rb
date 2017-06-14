class Player
  include Scoring
  attr_reader :hand

  def initialize
    @hand = Hand.new
  end

  def get_cards(deck)
    if empty_hand?
      2.times do
        @hand.cards << deck.deal_card
      end
    else
      @hand.cards << deck.deal_card
    end
  end

  def blackjack?
    hand_score == 21
  end

  def bust?
    hand_score > 21
  end

  def hand_score
    score(@hand)
  end

  def dealer_showing_hand_score(dealer)
    score(dealer.show_hand)
  end

  def hand_count
    @hand.cards.count
  end

  def empty_hand?
    @hand.cards.empty?
  end
end
