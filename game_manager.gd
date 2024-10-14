extends Node

var player1_turn: bool = true 
var gagne_player_1: bool = false
var gagne_player_2: bool = false
@onready var cpu_player_1: Node2D = $"../CPU Player"
@onready var cpu_player_2: Node2D = $"../CPU Player 2"
@onready var available_cards: Node2D = $"../Available cards"
@onready var used_cards: Node2D = $"../Used cards"
@onready var player_cards_1: Node2D = $"../CPU Player/Player cards"
@onready var player_cards_2: Node2D = $"../CPU Player 2/Player cards"
var current_card

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
# gérer chaque cpu_joueur
func _gerer_joueur(last_card, cpu_player_n, player_cards_n, gagne_player_n) -> void:
	var turn_finished = false
	
	while not turn_finished:
		
		var chosen_card = cpu_player_n.play(last_card, 0)  # choisir la première carte à jouer
		
		# vérifier si la carte est valide ou pas
		if allowAction(chosen_card, last_card):
			# Si c'est ok, alors il peut joueur cette carte
			print("La carte valide")
			player_cards_n.deck.erase(chosen_card)  # enlever-la de player_cards
			used_cards.deck.append(chosen_card)  # mettre à jour le deck déjà utilisé
			
			# vérifier si le deck dans la main est vide déjà
			if player_cards_n.deck.size() == 0:
				gagne_player_n = true
				return  # si gagné, alors finir le jeu
			else:
				turn_finished = true  # Si la carte est valide et le jeu n'est pas fini, alors finir ce tour
		else:
			# Si la carte n'est pas valide, re-jouer une fois
			print("Carte invalide, essayez encore.")
		
		# S'il n'y a pas de carte valide, piocher une et finir ce tour
		if cpu_player_n.playableCards(last_card).size() == 0:
			print("Pas de carte valide, en train de piocher...")
			player_cards_n.deck.append(available_cards.take())  # piocher
			turn_finished = true  # finir ce tour

	# changer le joueur
	player1_turn = !player1_turn

# vérifier si le jeu est fini, sinon on continue
func continue_game() -> void:
	if gagne_player_1:
		print("Le joueur 1 a gagné!")
		return
	elif gagne_player_2:
		print("Le joueur 2 a gagné!")
		return
	else:
		# continuer le jeu
		var last_card = used_cards.peek()
		if player1_turn:
			_gerer_joueur(last_card, cpu_player_1, player_cards_1, gagne_player_1)
		else:
			_gerer_joueur(last_card, cpu_player_2, player_cards_2, gagne_player_2)
		
		# exécuter après la fin de frame actuelle, méthode du godot!
		call_deferred("continue_game")  

# initialisation, begin game!
func _ready() -> void:
	player1_turn = true 
	continue_game()
