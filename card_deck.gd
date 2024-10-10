# extends Reference
extends Node

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


enum CardColor {
	RED,
	YELLOW,
	GREEN,
	BLUE,
	WILD
}

enum CardType {
	NUMBER,
	SKIP,
	REVERSE,
	DRAW_TWO,
	WILD,
	WILD_DRAW_FOUR
}

class CardDeck:
	var color: int
	var type: int
	var value: int # For numbered cards, this is 0-9; for others, it's ignored

	func _init(color: int, type: int, value: int = -1):
		self.color = color
		self.type = type
		self.value = value

var deck: Array = []

func create_deck():
	# Add numbered cards
	for color in [CardColor.RED, CardColor.YELLOW, CardColor.GREEN, CardColor.BLUE]:
		for number in range(10): # 0-9
			deck.append(Card.new(color, CardType.NUMBER, number))
			if number > 0: # Each color has two of 1-9
				deck.append(Card.new(color, CardType.NUMBER, number))

	# Add action cards
	for color in [CardColor.RED, CardColor.YELLOW, CardColor.GREEN, CardColor.BLUE]:
		deck.append(Card.new(color, CardType.SKIP))
		deck.append(Card.new(color, CardType.REVERSE))
		deck.append(Card.new(color, CardType.DRAW_TWO))

	# Add wild cards
	deck.append(Card.new(CardColor.WILD, CardType.WILD))
	deck.append(Card.new(CardColor.WILD, CardType.WILD_DRAW_FOUR))
	
	#functions:
	#take: return last card and size--
	#peek: return last card
	#choose: return card at index X and size--
	

		
		

func take():
	#return last card and size-- 
func peek():
	#return last card in the available deck
func choose():
	#return card at index X and size--
	
	# Shuffle the deck if needed
	# deck.shuffle() #built in function that shuffles the array of decks
