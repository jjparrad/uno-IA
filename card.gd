# extends Reference
extends Object

class_name Card

enum CardColor {
	RED,
	YELLOW,
	GREEN,
	BLUE,
	WILD
}

var enum_colors = {
	CardColor.RED: "Red",
	CardColor.YELLOW: "Yellow",
	CardColor.GREEN: "Green",
	CardColor.BLUE: "Blue",
	CardColor.WILD: "Wild"
}

enum CardType {
	NUMBER,
	SKIP,
	REVERSE,
	DRAW_TWO,
	WILD,
	WILD_DRAW_FOUR
}

var enum_types = {
	CardType.NUMBER: "Number",
	CardType.SKIP: "Skip",
	CardType.REVERSE: "Reverse",
	CardType.DRAW_TWO: "+2",
	CardType.WILD: "Wild",
	CardType.WILD_DRAW_FOUR: "+4"
}

var color: CardColor
var type: CardType
var value: int # For numbered cards, this is 0-9; for others, it's ignored

func _init(col, typ, val = -1):
	color = col
	type = typ
	value = val

func print() -> void:
	print(str(value) + ", " + enum_colors[color] + ", " + enum_types[type])
