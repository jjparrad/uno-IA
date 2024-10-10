# extends Reference
extends Node

class CardDeck:
	var color: int
	var type: int
	var value: int # For numbered cards, this is 0-9; for others, it's ignored

	func _init(color: int, type: int, value: int = -1):
		self.color = color
		self.type = type
		self.value = value

var deck: Array = []

func take():
	#return last card and size-- 
func peek():
	#return last card in the available deck
func choose():
	#return card at index X and size--
	
	# Shuffle the deck if needed
	# deck.shuffle() #built in function that shuffles the array of decks
