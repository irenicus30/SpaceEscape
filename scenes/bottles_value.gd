extends Label

var bottles_caught

func _ready():
	bottles_caught = 0

func _process(delta):	
	text = String(bottles_caught)

func on_bottle_caught():
	bottles_caught += 1