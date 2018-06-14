extends MarginContainer


export (int) var max_oxygen
var current_oxygen = 0
var oxygen_value
var oxygen_bar
var is_game_over

signal game_over

func _ready():
	var MAIN = get_node("/root/main")
	connect("game_over", MAIN, "on_game_over")
	current_oxygen = max_oxygen
	oxygen_value = get_node("HBoxContainer/VBoxContainer/oxygen_description/oxygen_value")
	oxygen_value.text = String(current_oxygen) + "%"
	oxygen_bar = get_node("HBoxContainer/VBoxContainer/oxygen_bar")
	oxygen_bar.max_value = max_oxygen
	oxygen_bar.value = current_oxygen

func on_bottle_cought(body):
	if not is_game_over:
		if body.name != "astronaut":
			return
		if current_oxygen + 10 > 100:
			current_oxygen = 100
		else:
			current_oxygen = current_oxygen + 10
		oxygen_value.text = String(current_oxygen) + "%"
		oxygen_bar.value = current_oxygen

func on_oxygen_burn():
	if not is_game_over:
		current_oxygen = current_oxygen-0.1
		oxygen_value.text = String(current_oxygen) + "%"
		oxygen_bar.value = current_oxygen
		if current_oxygen <= 0:
			is_game_over = true
			emit_signal("game_over")
			
func on_asteroid_crash():
	current_oxygen = current_oxygen-10
	oxygen_value.text = String(current_oxygen) + "%"
	oxygen_bar.value = current_oxygen
	
		