extends MarginContainer


export (int) var max_oxygen
var current_oxygen = 0
var oxygen_value
var oxygen_bar

func _ready():
	current_oxygen = max_oxygen/2
	oxygen_value = get_node("HBoxContainer/VBoxContainer/oxygen_description/oxygen_value")
	oxygen_value.text = String(current_oxygen) + "%"
	oxygen_bar = get_node("HBoxContainer/VBoxContainer/oxygen_bar")
	oxygen_bar.max_value = max_oxygen
	oxygen_bar.value = current_oxygen

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func on_bottle_cought(body):
	if body.name != "astronaut":
		return
	if current_oxygen + 20 > 100:
		current_oxygen = 100
	else:
		current_oxygen = current_oxygen + 20
	oxygen_value.text = String(current_oxygen) + "%"
	oxygen_bar.value = current_oxygen

func on_oxygen_burn():
	current_oxygen = current_oxygen-1
	oxygen_value.text = String(current_oxygen) + "%"
	oxygen_bar.value = current_oxygen
	if current_oxygen <= 0:
		game_over()

func game_over():
	pass