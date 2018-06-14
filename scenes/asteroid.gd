extends Sprite

signal asteroid_crash


func _ready():
	var GUI = get_node("/root/main/CanvasLayer/GUI")
	connect("asteroid_crash", GUI, "on_asteroid_crash")
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on__body_entered(body):
	if body.name == "astronaut":
		emit_signal("asteroid_crash", body)
		print("SYGNAAAAL")
