class Dealer
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

  def draw(deck)
    return hand_score if bust? || blackjack?
    return hand_score if hand_score >= 17
    get_cards(deck)
    draw(deck)
  end

  def bust?
    hand_score > 21
  end

  def blackjack?
    hand_score == 21
  end

  def hand_score
    score(@hand)
  end

  def show_hand
    # show all cards besides "hole" card
    visible_hand = Hand.new
    visible_hand.cards = @hand.cards[1, @hand.cards.length]
    visible_hand
  end

  def hand_count
    @hand.cards.count
  end

  def empty_hand?
    @hand.cards.empty?
  end
end
