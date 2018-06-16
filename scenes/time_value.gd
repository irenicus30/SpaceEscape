extends Label

var start_time = 0
var counting = true

func _ready():
	start_time = OS.get_unix_time()

func _process(delta):
	if counting:
		text = String( OS.get_unix_time() - start_time)

func on_game_over():
	counting = false