extends Label

var start_time = 0

func _ready():
	start_time = OS.get_unix_time()

func _process(delta):
	text = String( OS.get_unix_time() - start_time)
