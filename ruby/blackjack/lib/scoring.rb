module Scoring
  def score(hand)
    score = 0
    cards = hand.cards.partition { |card| card.name == :ace }
    aces = cards[0].count
    remaining = cards[1]
    remaining.each do |card|
      score += card.value
    end
    score += (aces * 11)
    score = reduce_aces(score, aces)
  end

  def reduce_aces(score, aces)
    return score if score <= 21
    return score if aces < 1
    reduce_aces(score - 10, aces - 1)
  end
end
