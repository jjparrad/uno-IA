# extends Reference
extends Node

class Cards:
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
		
