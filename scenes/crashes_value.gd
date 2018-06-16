extends Label

var asteroid_crash

func _ready():
	asteroid_crash = 0

func _process(delta):	
	text = String(asteroid_crash)

func on_asteroid_crashed():
	asteroid_crash += 1
