extends Object

class_name GameEnvironment

var playerOnTurn: int
var lastCard: Card
var numberOfCardsPlayers: Array[int]
var numberOfAvailableCards: int
var totalDraw: int

func _init(playerTurn, lastPlayedCard, numberOfPlayers, numberOfCardsPerPlayers, numberOfInitialCards):
	playerOnTurn = playerTurn
	lastCard = lastPlayedCard
	
	numberOfCardsPlayers = []
	numberOfCardsPlayers.resize(numberOfPlayers)
	numberOfCardsPlayers.fill(numberOfCardsPerPlayers)
	
	numberOfAvailableCards = numberOfInitialCards
	totalDraw = 0
