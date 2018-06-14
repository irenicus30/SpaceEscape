extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var index = 0
var is_info_text = false

func _ready():
	#Initialization here
	set_process_input(true)
	#Play the sound this also can be replaced by simply setting the autoplay property to true.
	get_node("Audio").play()
	#Set window title
	OS.set_window_title("SpaceEscape")
	#Hide mouse.
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)	

		
func _input(event):
	if event.is_action("ui_up") && event.is_pressed() && !event.is_echo():
		get_node("Info_text").visible = false
		if(index != 0):
			index -= 1
			var x = get_node("Arrow").get_rect().position.x
			var y = get_node("Arrow").get_rect().position.y - 80
			get_node("Arrow").rect_position.x = x
			get_node("Arrow").rect_position.y = y
	if event.is_action("ui_down") && event.is_pressed() && !event.is_echo():
		get_node("Info_text").visible = false
		if(index != 2):
			index += 1
			var x = get_node("Arrow").get_rect().position.x
			var y = get_node("Arrow").get_rect().position.y + 80
			get_node("Arrow").rect_position.x = x
			get_node("Arrow").rect_position.y = y
	if event.is_action("ui_accept") && event.is_pressed() && !event.is_echo():
		if (index == 0):
			get_tree().change_scene("res://scenes//main.tscn")
		if (index == 1):
			get_node("Info_text").visible = true	
		if(index == 2):
			get_tree().quit()
