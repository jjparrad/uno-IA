extends Node2D


var playerName: String
var playStack: Array


func _init(playerName: String, ):
	self.playerName = playerName

func draw(numberOfCards: int) -> void:
	var drawCards: Array # Init draw cards array
	
	for i in 3:
		drawCards.append(get_node("../Available Card").take()) # Get draw cards
	
	get_node("Player cards").deck.append_array(drawCards) # Add draw cards to the deck
	
	
func canPlay(last_card: Card) -> bool:
	if last_card not in playStack:
		playStack.append(last_card)
	return playableCards(last_card).is_empty()

func playableCards(last_card: Card)-> Array:
	var playableCards : Array
	if last_card.type == Card.CardType.DRAW_TWO:
		for card in get_node("Player cards").deck:
			if card.type == Card.CardType.DRAW_TWO || card.type == Card.CardType.WILD_DRAW_FOUR:
				playableCards.append(card)
	elif last_card.type == Card.CardType.WILD_DRAW_FOUR:
		for card in get_node("Player cards").deck:
			if card.type == Card.CardType.WILD_DRAW_FOUR:
				playableCards.append(card)
	else:
		for card in get_node("Player cards").deck:
			if card.color == last_card.color || card.type == Card.CardType.WILD || card.type == Card.CardType.WILD_DRAW_FOUR:
				playableCards.append(card)
		
	return playableCards

func play(last_card: Card, numberOfCard : int) -> Card:
	var chosenCard : Card
	chosenCard = choose(playableCards(last_card), numberOfCard)
	get_node("Player cards").deck.erase(chosenCard)
	playStack.append(last_card)
	return chosenCard


func choose(playableCards: Array, numberOfCard : int) -> Card:
	# Some strategy algorithm
	return playableCards[0]
