extends Node

@export var cardsPerPlayer: int = 10

var deck: Array[Card] = []
# var cards = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

func create_deck():
	var colors = [Card.CardColor.RED, Card.CardColor.YELLOW, Card.CardColor.GREEN, Card.CardColor.BLUE]
	# Add numbered cards
	for color in colors:
		deck.append(Card.new(color, Card.CardType.SKIP))
		deck.append(Card.new(color, Card.CardType.SKIP))
		deck.append(Card.new(color, Card.CardType.REVERSE))
		deck.append(Card.new(color, Card.CardType.REVERSE))
		deck.append(Card.new(color, Card.CardType.DRAW_TWO))
		deck.append(Card.new(color, Card.CardType.DRAW_TWO))
		for number in range(10): # 0-9
			deck.append(Card.new(color, Card.CardType.NUMBER, number))
			if number > 0: # Each color has two of 1-9 (only 1 zero)
				deck.append(Card.new(color, Card.CardType.NUMBER, number))

	# Add wild cards
	deck.append(Card.new(Card.CardColor.WILD, Card.CardType.WILD))
	deck.append(Card.new(Card.CardColor.WILD, Card.CardType.WILD))
	deck.append(Card.new(Card.CardColor.WILD, Card.CardType.WILD))
	deck.append(Card.new(Card.CardColor.WILD, Card.CardType.WILD))
	deck.append(Card.new(Card.CardColor.WILD, Card.CardType.WILD_DRAW_FOUR))
	deck.append(Card.new(Card.CardColor.WILD, Card.CardType.WILD_DRAW_FOUR))
	deck.append(Card.new(Card.CardColor.WILD, Card.CardType.WILD_DRAW_FOUR))
	deck.append(Card.new(Card.CardColor.WILD, Card.CardType.WILD_DRAW_FOUR))
	
func dealCards() -> void:
	deck.shuffle()
		
	var player1Cards = deck.slice(0, cardsPerPlayer)
	var player1Deck = get_node("../CPU Player/Player cards")
	player1Deck.deck = player1Cards
	print("Player 1 cards:")
	player1Deck.print()
	
	var player2Cards = deck.slice(cardsPerPlayer, cardsPerPlayer * 2)
	var player2Deck = get_node("../CPU Player 2/Player cards")
	player2Deck.deck = player2Cards
	print("Player 2 cards:")
	player1Deck.print()
	
	var availableCards = deck.slice(-2, cardsPerPlayer * 2 - 1, -1)
	var pioche = get_node("../Available cards")
	pioche.deck = availableCards
	
	var firstCard: Array[Card] = [deck[deck.size() - 1]]
	var used = get_node("../Used cards")
	used.deck = firstCard
	print("First card:")
	used.print()
	
	#player1Deck.print()
	
func reshuffleCards() -> void:
	var usedCards = get_node("Used cards").deck
	usedCards.shuffle()
	
	var availableCards = get_node("Available cards").deck
	availableCards = usedCards.slice(1, usedCards.size())
	usedCards = usedCards.slice(0, 1)
