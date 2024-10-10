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
	deck.slice(0,deck.size()-1) #remove the card on top of the available cards
	# return availableCards[0]
	
func peek():
	#return last card
	return deck[0]
	
func choose(index: int):
	# switch the chosen card in the deck with the first card [0]
	var temp = deck[index]
	deck[index] = deck[0]
	deck[0] = temp
	# slice the player's deck [0,playerDeck.size()]
	deck.slice(0, deck.size()-1)
		
# Shuffle the deck if needed
# deck.shuffle() #built in function that shuffles the array of decks
