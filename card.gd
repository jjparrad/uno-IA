# extends Reference
class_name Card
extends Object

enum CardColor {
	RED,
	YELLOW,
	GREEN,
	BLUE,
	WILD
}

enum CardType {
	NUMBER,
	SKIP,
	REVERSE,
	DRAW_TWO,
	WILD,
	WILD_DRAW_FOUR
}

var color: CardColor
var type: CardType
var value: int # For numbered cards, this is 0-9; for others, it's ignored

func _init(color, type, value = -1):
	color = color
	type = type
	value = value
	
