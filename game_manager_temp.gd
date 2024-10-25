extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var cardsDealer = get_node("../Cards dealer")
	cardsDealer.create_deck()
	cardsDealer.dealCards()
	
	var player1Cards = get_node("../CPU Player/Player cards")
	
	var availableCards = get_node("../Available cards")
	player1Cards.display()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
