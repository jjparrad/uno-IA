extends Node
var cardsPerPlayer: int = 10

var deck: Array[Card] = []
# var cards = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

var currentId = 0

func create_deck():
	var colors = [Card.CardColor.RED, Card.CardColor.YELLOW, Card.CardColor.GREEN, Card.CardColor.BLUE]
	# Add numbered cards
	for color in colors:
		deck.append(Card.new(color,  Card.CardType.SKIP, generateCardId()))
		deck.append(Card.new(color, Card.CardType.SKIP, generateCardId()))
		deck.append(Card.new(color, Card.CardType.REVERSE, generateCardId()))
		deck.append(Card.new(color, Card.CardType.REVERSE, generateCardId()))
		deck.append(Card.new(color, Card.CardType.DRAW_TWO, generateCardId()))
		deck.append(Card.new(color, Card.CardType.DRAW_TWO, generateCardId()))
		for number in range(10): # 0-9
			deck.append(Card.new(color ,Card.CardType.NUMBER, generateCardId(), number))
			if number > 0: # Each color has two of 1-9 (only 1 zero)
				deck.append(Card.new(color, Card.CardType.NUMBER, generateCardId(), number))

	# Add wild cards
	deck.append(Card.new(Card.CardColor.WILD, Card.CardType.WILD, generateCardId()))
	deck.append(Card.new(Card.CardColor.WILD, Card.CardType.WILD, generateCardId()))
	deck.append(Card.new(Card.CardColor.WILD, Card.CardType.WILD, generateCardId()))
	deck.append(Card.new(Card.CardColor.WILD, Card.CardType.WILD, generateCardId()))
	deck.append(Card.new(Card.CardColor.WILD, Card.CardType.WILD_DRAW_FOUR, generateCardId()))
	deck.append(Card.new(Card.CardColor.WILD, Card.CardType.WILD_DRAW_FOUR, generateCardId()))
	deck.append(Card.new(Card.CardColor.WILD, Card.CardType.WILD_DRAW_FOUR, generateCardId()))
	deck.append(Card.new(Card.CardColor.WILD, Card.CardType.WILD_DRAW_FOUR, generateCardId()))
	
func dealCards() -> void:
	deck.shuffle()
	
	var firstCard: Card
	var index = 0
	for card in deck:
		if card.type == Card.CardType.NUMBER:
			firstCard = card
			break
		index += 1
	var used = get_node("../Used cards")
	used.addCardToDeck(firstCard)
	deck.remove_at(index)
	print("First card:")
	used.print()
	
	var player1Cards = deck.slice(0, cardsPerPlayer)
	var player1Deck = get_node("../CPU Player/Player cards")
	player1Deck.deck = player1Cards
	print("Player 1 cards:")
	player1Deck.print()
	
	var player2Cards = deck.slice(cardsPerPlayer, cardsPerPlayer * 2)
	var player2Deck = get_node("../CPU Player 2/Player cards")
	player2Deck.deck = player2Cards
	print("Player 2 cards:")
	player2Deck.print()
	
	var player3Cards = deck.slice(cardsPerPlayer * 2, cardsPerPlayer * 3)
	var player3Deck = get_node("../CPU Player 3/Player cards")
	player3Deck.deck = player3Cards
	print("Player 3 cards:")
	player3Deck.print()
	
	var player4Cards = deck.slice(cardsPerPlayer * 3, cardsPerPlayer * 4)
	var player4Deck = get_node("../CPU Player 4/Player cards")
	player4Deck.deck = player4Cards
	print("Player 4 cards:")
	player4Deck.print()
	
	var availableCards = deck.slice(-1, cardsPerPlayer * 4 - 1, -1)
	var pioche = get_node("../Available cards")
	pioche.deck = availableCards
	print("Available cards:")
	pioche.print()
	
func reshuffleCards() -> void: # TODO : This function is not working properly
	var usedCards = get_node("../Used cards")
	var availableCards = get_node("../Available cards")
	
	var lastUsedCard = usedCards.deck.pop_back()
	usedCards.deck.shuffle()
	
	availableCards.deck = usedCards
	usedCards = [lastUsedCard]

func generateCardId():
	currentId += 1
	return currentId
