extends Node

@export var cardsPerPlayer: int = 10

var deck: Array = []
var cards = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_deck()
	dealCards()

func create_deck():
	var colors = [Card.CardColor.RED, Card.CardColor.YELLOW, Card.CardColor.GREEN, Card.CardColor.BLUE]
	# Add numbered cards
	for color in colors:
		for number in range(10): # 0-9
			deck.append(Card.new(color, Card.CardType.NUMBER, number))
			if number > 0: # Each color has two of 1-9
				deck.append(Card.new(color, Card.CardType.NUMBER, number))

	# Add action cards
	for color in colors:
		deck.append(Card.new(color, Card.CardType.SKIP))
		deck.append(Card.new(color, Card.CardType.REVERSE))
		deck.append(Card.new(color, Card.CardType.DRAW_TWO))

	# Add wild cards
	deck.append(Card.new(Card.CardColor.WILD, Card.CardType.WILD))
	deck.append(Card.new(Card.CardColor.WILD, Card.CardType.WILD_DRAW_FOUR))
	
func dealCards() -> void:
	#deck = cards;
	deck.shuffle()
	var player1Cards = deck.slice(0, cardsPerPlayer)
	var player2Cards = deck.slice(cardsPerPlayer, cardsPerPlayer * 2)
	var availableCards = deck.slice(-2, cardsPerPlayer * 2 - 1, -1)
	var firstCard = deck[deck.size() - 1]
	
	#var player1Deck = get_node("Player cards")
	
	print(player1Cards[5].color)
	print(player2Cards)
	print(availableCards)
	print(firstCard)
	
func reshuffleCards() -> void:
	#var usedCards = get_node("Used cards")
	var usedCards = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 0 ]
	usedCards.shuffle()
	
	#var availableCards = get_node("Used cards")
	var availableCards = []
	availableCards = usedCards
	print(availableCards)
	
