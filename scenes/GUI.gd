extends MarginContainer


export (int) var max_oxygen
var current_oxygen = 0
var oxygen_value
var oxygen_bar
var is_game_over
var bottles_caught = 0
var asteroid_crashed = 0

signal game_over
signal bottle_caught
signal asteroid_crashed

func _ready():
	var MAIN = get_node("/root/main")
	connect("game_over", MAIN, "on_game_over")
	var TIME = get_node("HBoxContainer/VBoxContainer2/MarginContainer/time/time_value")
	connect("game_over", TIME, "on_game_over")
	var BOTTLES = get_node("HBoxContainer/VBoxContainer2/MarginContainer2/bottles/bottles_value")
	connect("bottle_caught", BOTTLES, "on_bottle_caught")
	var CRASHES = get_node("HBoxContainer/VBoxContainer2/MarginContainer3/crashes/crashes_value")
	connect("asteroid_crashed", CRASHES, "on_asteroid_crashed")
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
		emit_signal('bottle_caught')


func on_oxygen_burn():
	if not is_game_over:
		current_oxygen = current_oxygen-0.1
		oxygen_value.text = String(current_oxygen) + "%"
		oxygen_bar.value = current_oxygen
		if current_oxygen <= 0:
			is_game_over = true
			emit_signal("game_over")
			
func on_asteroid_crash():
	current_oxygen = current_oxygen - 2
	oxygen_value.text = String(current_oxygen) + "%"
	oxygen_bar.value = current_oxygen
	emit_signal('asteroid_crashed')
	
	
		