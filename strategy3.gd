extends Node

func chooseCard(playableCards: Array, numberOfCardsRival: int, numberOfCardsPioche: int, playStack: Array) -> Card:
	# Some strategy algorithm
	var card: Card = playableCards[0]
	if card.type == Card.CardType.WILD or card.type == Card.CardType.WILD_DRAW_FOUR:
		card.color = Card.CardColor.RED
	return card
