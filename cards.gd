# extends Reference
extends Node

@export var offsetBetweenCards: int = 20

var deck: Array[Card] = []
var cardSprites: Dictionary = {}

func take():
	return deck.pop_back()
	
func getLastCard():
	return deck[-1]
	
func eraseCard(card: Card):
	deck.erase(card)
	var spriteToRemove = cardSprites[card]
	spriteToRemove.queue_free()
	updateCardsPositions()
	
func addCardToDeck(card: Card):
	deck.push_back(card)
	var sprite2d = Sprite2D.new()
	cardSprites[card] = sprite2d
	var texture = load("res://assets/cards/" + card.image_path  + ".png")
	sprite2d.texture = texture
	sprite2d.scale = Vector2(0.2, 0.2)
	add_child(sprite2d)
	
func addCardsToDeck(cards: Array[Card]):
	for card in cards:
		addCardToDeck(card)

func print(): 
	for card in deck:
		card.print()

func display():
	var index = 0
	for card in deck:
		var sprite2d = Sprite2D.new()
		cardSprites[card] = sprite2d
		var texture = load("res://assets/cards/" + card.image_path  + ".png")
		sprite2d.texture = texture
		sprite2d.scale = Vector2(0.2, 0.2)
		sprite2d.position.y = offsetBetweenCards * index
		add_child(sprite2d)
		
		index += 1

func updateCardsPositions(): 
	var index = 0
	for card in deck:
		var sprite2d = cardSprites[card]
		sprite2d.position.y = offsetBetweenCards * index
		
		index += 1

func displayLast():
	var card = deck[-1]
	var sprite2d = Sprite2D.new()
	var texture = load("res://assets/cards/" + card.image_path  + ".png")
	sprite2d.texture = texture
	sprite2d.scale = Vector2(0.2, 0.2)
	add_child(sprite2d)

func createRemainingLabel():
	var sprite2d = Sprite2D.new()
	var texture = load("res://assets/cards/card.png")
	sprite2d.texture = texture
	sprite2d.scale = Vector2(0.12, 0.12)
	add_child(sprite2d)
	updateRemainingLabel()

func updateRemainingLabel():
	var label = get_node("Remaining Label")
	label.text = str(deck.size())
