extends Node2D

@export var playerName: String
@export var id: int
var manager: Node
var cards: Node2D

var playStack: Array
var myLastPlayedCardId: int
var lastPlayedCardId: int
var lastActivePlayer: int
var thinkingTime: float
var thinkingStart: int
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	cards = get_node("Player cards")
	manager = get_node("../Game manager")
	cards.display()
	think()

func _process(delta: float) -> void:
	if manager == null or manager.pause:
		return
	
	var environment = manager.getEnvironment()
	if environment.lastCard.id != lastPlayedCardId:
		lastPlayedCardId = environment.lastCard.id
		playStack.append(environment.lastCard)
		think()
	
	var currentTime = Time.get_ticks_msec()
	var elapsedTime = currentTime - thinkingStart
	
	if elapsedTime < (thinkingTime * 1000):
		return
		
	if environment.playerOnTurn == id:
		if manager.canPlay(id):
			print("Player ", id, " turn")
			var card = play(environment)
			manager.playTurn(card)
			cards.updateCardsPositions()
			return
	
	var card = canSteal(environment.lastCard)
	if card != null:
		if manager.canPlay(id):
			print("Player ", id, " steals turn")
			useCard(card)
			manager.playTurn(card)
			cards.updateCardsPositions()
			return
	
func think() -> void:
	thinkingStart = Time.get_ticks_msec()
	#thinkingTime = rng.randf_range(0.5, 1.5)
	thinkingTime = rng.randf_range(5, 8)
	return
	
func draw(numberOfCards: int) -> void:
	var drawCards: Array[Card]
	var availableCards = get_node("../Available cards")
	for i in range(numberOfCards):
		drawCards.append(availableCards.take())
	
	get_node("Player cards").addCardsToDeck(drawCards)
	
func findPlayableCards(last_card: Card)-> Array:
	var playableCards : Array
	for card in get_node("Player cards").deck:
		if last_card.type == Card.CardType.DRAW_TWO and last_card.active:
			if card.type == Card.CardType.DRAW_TWO or card.type == Card.CardType.WILD_DRAW_FOUR:
				playableCards.append(card)
		elif last_card.type == Card.CardType.WILD_DRAW_FOUR and last_card.active:
			if card.type == Card.CardType.WILD_DRAW_FOUR:
				playableCards.append(card)
		elif card.type == Card.CardType.WILD or card.type == Card.CardType.WILD_DRAW_FOUR:
			playableCards.append(card)
		elif last_card.type == Card.CardType.WILD or last_card.type == Card.CardType.WILD_DRAW_FOUR:
			if last_card.color == card.color:
				playableCards.append(card)
		elif last_card.type != Card.CardType.NUMBER:
			if card.color == last_card.color or last_card.type == card.type:
				playableCards.append(card)
		elif last_card.type == Card.CardType.NUMBER:
			if card.color == last_card.color or last_card.value == card.value:
				playableCards.append(card)
	return playableCards

func play(environment) -> Card:
	var last_card: Card = environment.lastCard
	var totalDraw: int = environment.totalDraw
	var numberOfCardsRival: int = 0
	var numberOfCardsPioche: int = 0
	
	var playableCards = findPlayableCards(last_card)
	if playableCards.is_empty():
		if (last_card.type == Card.CardType.WILD_DRAW_FOUR or last_card.type == Card.CardType.DRAW_TWO) and last_card.active:
			draw(totalDraw)
			think()
			last_card.active = false
			print("I took ", totalDraw, " cards\n")
		else:
			draw(1)
			think()
			print("I took 1 card\n")
		return null
	
	var chosenCard: Card = get_node("Strategy").chooseCard(playableCards, numberOfCardsRival, numberOfCardsPioche, playStack)
	useCard(chosenCard)
	return chosenCard

func canSteal(currentCard: Card) -> Card:
	for card in get_node("Player cards").deck:
		if card.type == currentCard.type:
			if currentCard.type == Card.CardType.WILD or currentCard.type == Card.CardType.WILD_DRAW_FOUR:
				continue # We could change this to "return card", but if so we must ask the strategy to pick a color
			elif currentCard.type == Card.CardType.NUMBER:
				if card.color == currentCard.color and card.value == currentCard.value:
					return card
			elif card.color == currentCard.color:
				return card
	return null

func useCard(card: Card):
	get_node("Player cards").eraseCard(card)
	playStack.append(card)
	myLastPlayedCardId = card.id
