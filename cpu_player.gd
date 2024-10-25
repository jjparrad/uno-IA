extends Node2D

@export var playerName: String
var playStack: Array
var myLastPlayedCardId: int

func draw(numberOfCards: int) -> void:
	var drawCards: Array[Card]
	var availableCards = get_node("../Available cards")
	for i in range(numberOfCards):
		drawCards.append(availableCards.take())
	
	get_node("Player cards").addCardsToDeck(drawCards)
	
func findPlayableCards(last_card: Card)-> Array:
	var playableCards : Array
	for card in get_node("Player cards").deck:
		if last_card.type == Card.CardType.DRAW_TWO and last_card.active:
			if card.type == Card.CardType.DRAW_TWO or card.type == Card.CardType.WILD_DRAW_FOUR:
				playableCards.append(card)
		elif last_card.type == Card.CardType.WILD_DRAW_FOUR and last_card.active:
			if card.type == Card.CardType.WILD_DRAW_FOUR:
				playableCards.append(card)
		elif card.type == Card.CardType.WILD or card.type == Card.CardType.WILD_DRAW_FOUR:
			playableCards.append(card)
		elif last_card.type == Card.CardType.WILD or last_card.type == Card.CardType.WILD_DRAW_FOUR:
			if last_card.color == card.color:
				playableCards.append(card)
		elif last_card.type != Card.CardType.NUMBER:
			if card.color == last_card.color or last_card.type == card.type:
				playableCards.append(card)
		elif last_card.type == Card.CardType.NUMBER:
			if card.color == last_card.color or last_card.value == card.value:
				playableCards.append(card)
	return playableCards

func play(last_card: Card, numberOfCardsRival: int, numberOfCardsPioche: int, totalDraw: int) -> Card:
	if last_card.id != myLastPlayedCardId:
		playStack.append(last_card)
	
	var playableCards = findPlayableCards(last_card)
	if playableCards.is_empty():
		if (last_card.type == Card.CardType.WILD_DRAW_FOUR or last_card.type == Card.CardType.DRAW_TWO) and last_card.active:
			draw(totalDraw)
			last_card.active = false
		else:
			draw(1)
		return null
	
	var chosenCard: Card = choose(playableCards, numberOfCardsRival, numberOfCardsPioche)
	get_node("Player cards").eraseCard(chosenCard)
	playStack.append(chosenCard)
	myLastPlayedCardId = chosenCard.id
	return chosenCard


func choose(playableCards: Array, numberOfCardsRival: int, numberOfCardsPioche: int) -> Card:
	# Some strategy algorithm
	var card: Card = playableCards[0]
	if card.type == Card.CardType.WILD or card.type == Card.CardType.WILD_DRAW_FOUR:
		card.color = Card.CardColor.RED
	return card
