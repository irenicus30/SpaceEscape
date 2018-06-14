extends Sprite

signal bottle_cought


func _ready():
	var GUI = get_node("/root/main/CanvasLayer/GUI")
	connect("bottle_cought", GUI, "on_bottle_cought")

func _on_Area2D_body_entered(body):
	if body.name == "astronaut":
		emit_signal("bottle_cought", body)
	queue_free()