extends Node

@onready var cpu_player_1: Node2D = $"../CPU Player"
@onready var cpu_player_2: Node2D = $"../CPU Player 2"
@onready var player_cards_1: Node2D = $"../CPU Player/Player cards"
@onready var player_cards_2: Node2D = $"../CPU Player 2/Player cards"
@onready var available_cards: Node2D = $"../Available cards"
@onready var used_cards: Node2D = $"../Used cards"
@onready var cards_dealer: Node = $"../Cards dealer"

var player1_turn: bool = true 
var current_card: Card
var nextPressed: bool = false
var totalDraw: int = 0

# initialisation, begin game!
func _ready() -> void:
	cards_dealer.create_deck()
	cards_dealer.dealCards()
	displayCards()
	player1_turn = true 

func _process(delta: float) -> void:
	if nextPressed:
		continue_game()
		nextPressed = false

func handleNextClick():
	nextPressed = true

func displayCards():
	player_cards_1.display()
	player_cards_2.display()
	used_cards.displayLast()
	available_cards.createRemainingLabel()

# vérifier si le jeu est fini, sinon on continue
func continue_game() -> void:
	if player1_turn:
		current_card = playTurn(cpu_player_1)
	else:
		current_card = playTurn(cpu_player_2)
		
	player_cards_1.updateCardsPositions()
	player_cards_2.updateCardsPositions()
	available_cards.updateRemainingLabel()
	
	if player_cards_1.deck.size() == 0:
		print("Le joueur 1 a gagné!")
		return
	elif player_cards_2.deck.size() == 0:
		print("Le joueur 2 a gagné!")
		return
	
	if available_cards.deck.size() < 4:
		cards_dealer.reshuffleCards()
		available_cards.updateRemainingLabel()
	
	if current_card == null:
		player1_turn = !player1_turn
		return
	
	if current_card.type == Card.CardType.REVERSE or current_card.type == Card.CardType.SKIP: 
		return
	
	player1_turn = !player1_turn

func playTurn(player) -> Card:
	var last_card = used_cards.getLastCard()
	
	var chosen_card: Card = player.play(last_card, 6, available_cards.deck.size(), totalDraw)
	if chosen_card == null:
		totalDraw = 0
		return
		
	chosen_card.print()
	if chosen_card.type == Card.CardType.DRAW_TWO:
		totalDraw += 2
		chosen_card.active = true
		
	elif chosen_card.type == Card.CardType.WILD_DRAW_FOUR:
		totalDraw += 4
		chosen_card.active = true
		
	used_cards.addCardToDeck(chosen_card)
	
	return chosen_card

# vérifier si l'action est valide
func allowAction(chosen_card, last_card) -> bool:
	# vérifier le couleur
	if chosen_card.color == last_card.color:
		return true
	# vérifier si les num sont correspondants(si les deux sont de type NUMBER)
	if chosen_card.type == Card.CardType.NUMBER and last_card.type == Card.CardType.NUMBER:
		if chosen_card.value == last_card.value:
			return true
	# vérifier si il est WILD ou WILD_DRAW_FOUR
	if chosen_card.type == Card.CardType.WILD or chosen_card.type == Card.CardType.WILD_DRAW_FOUR:
		return true
	# vérifier SKIP, REVERSE, DRAW_TWO ou les restes...
	if chosen_card.type == last_card.type:
		return true
	return false
	


func _on_button_pressed() -> void:
	pass # Replace with function body.
