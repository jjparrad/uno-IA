extends Node

@onready var available_cards: Node2D = $"../Available cards"
@onready var used_cards: Node2D = $"../Used cards"
@onready var cards_dealer: Node = $"../Cards dealer"

@export var cardsPerPlayer: int = 6
@export var numberOfPlayers: int = 4
var reverse: bool = false
var pause = true
var winner = false
var currentEnvironment: GameEnvironment

# initialisation, begin game!
func _ready() -> void:
	cards_dealer.cardsPerPlayer = cardsPerPlayer
	cards_dealer.create_deck()
	cards_dealer.dealCards()
	displayCards()
	currentEnvironment = GameEnvironment.new(0, used_cards.getLastCard(), numberOfPlayers, cardsPerPlayer, available_cards.deck.size())
	
func displayCards():
	used_cards.displayLast()
	available_cards.createRemainingLabel()

func handleNextClick():
	pause = !pause

func getEnvironment() -> GameEnvironment:
	return currentEnvironment

func canPlay(player: int):
	if winner: return false
	if pause: return false
	currentEnvironment.playerOnTurn = player
	pause = true
	return true
	
func playTurn(card: Card):
	var numberOfPlayerCards = currentEnvironment.numberOfCardsPlayers[currentEnvironment.playerOnTurn];
	
	if card == null:
		numberOfPlayerCards += 1 if currentEnvironment.totalDraw == 0 else currentEnvironment.totalDraw
		currentEnvironment.numberOfCardsPlayers[currentEnvironment.playerOnTurn] = numberOfPlayerCards
		currentEnvironment.totalDraw = 0
		nextPlayer()
		pause = false
		return
	
	numberOfPlayerCards -= 1
	
	if numberOfPlayerCards == 0:
		print("Player ", currentEnvironment.playerOnTurn, " wins!")
		winner = true
		
	currentEnvironment.numberOfCardsPlayers[currentEnvironment.playerOnTurn] = numberOfPlayerCards
	
	print("** Player ", currentEnvironment.playerOnTurn, " played a card **")
	card.print()
	print("")
	
	if card.type == Card.CardType.DRAW_TWO:
		currentEnvironment.totalDraw += 2
		card.active = true
		
	elif card.type == Card.CardType.WILD_DRAW_FOUR:
		currentEnvironment.totalDraw += 4
		card.active = true
	
	used_cards.addCardToDeck(card)
	processCard(card)
	pause = false

func processCard(card: Card) -> void:
	available_cards.updateRemainingLabel()
	
	if available_cards.deck.size() < 4:
		cards_dealer.reshuffleCards()
		available_cards.updateRemainingLabel()
	
	currentEnvironment.numberOfAvailableCards = available_cards.deck.size()
	currentEnvironment.lastCard = card
	
	if card.type == Card.CardType.REVERSE:
		reverse = !reverse
	
	if card.type == Card.CardType.SKIP:
		nextPlayer()
		nextPlayer()
		return
		
	nextPlayer()
	
func nextPlayer():
	var currentPlayer = currentEnvironment.playerOnTurn
	var nextPlayer: int
	
	if reverse:
		nextPlayer = currentPlayer - 1
		if nextPlayer == -1:
			nextPlayer = numberOfPlayers - 1;
	else:
		nextPlayer = currentPlayer + 1
		if nextPlayer == numberOfPlayers:
			nextPlayer = 0;
	
	currentEnvironment.playerOnTurn = nextPlayer
