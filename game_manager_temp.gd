extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var cardsDealer = get_node("../Cards dealer")
	cardsDealer.create_deck()
	cardsDealer.dealCards()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
