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

var id: int
var color: CardColor
var type: CardType
var value: int # For numbered cards, this is 0-9; for others, it's -1
var image_path: String
var active: bool # for keeping track if a +2 or a +4 has already been used

func _init(col, typ, ide, val = -1):
	id = ide
	color = col
	type = typ
	value = val
	image_path = getImagePath()
	
func getImagePath():
	if type == CardType.NUMBER:
		return enum_colors[color].to_lower() + "_" + str(value)
	elif type == CardType.WILD:
		return "wild"
	elif type == CardType.WILD_DRAW_FOUR:
		return "take_four"
	elif type == CardType.DRAW_TWO:
		return enum_colors[color].to_lower() + "_take_two"
	else:
		return enum_colors[color].to_lower() + "_" + enum_types[type].to_lower()

func print() -> void:
	print(str(value) + ", " + enum_colors[color] + ", " + enum_types[type])
