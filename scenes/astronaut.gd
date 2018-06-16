extends RigidBody2D

signal oxygen_burn

export (int) var move_speed = 100
export (int) var rotate_speed = 10
export (float) var burn_speed_moving = 0.1
export (float) var burn_speed_idle = 0.3

var cumulative_delta = 0
var velocity = Vector2()
var should_torque_be_applied = 0

func _ready():
	var GUI = get_node("/root/main/CanvasLayer/GUI")
	connect("oxygen_burn", GUI, "on_oxygen_burn")

func get_input_for_move():
    velocity = Vector2()
    if Input.is_action_pressed('ui_right'):
        velocity.x += 1
    if Input.is_action_pressed('ui_left'):
        velocity.x -= 1
    if Input.is_action_pressed('ui_down'):
        velocity.y += 1
    if Input.is_action_pressed('ui_up'):
        velocity.y -= 1
    if velocity.length()==0:
        if Input.is_action_pressed('move_forward'):
            velocity = Vector2(sin(rotation_degrees), -cos(rotation_degrees))
        elif Input.is_action_pressed('move_backwards'):
            velocity = Vector2(-sin(rotation_degrees), cos(rotation_degrees))
    if velocity.length()>0:
        velocity = velocity.normalized() * move_speed
		
func get_input_for_rotate():
	if Input.is_action_pressed('rotate_right'):
		should_torque_be_applied = 1
	elif Input.is_action_pressed('rotate_left'):
		should_torque_be_applied = -1
	else:
		should_torque_be_applied = 0

func _physics_process(delta):
	get_input_for_move()
	apply_impulse(Vector2(), velocity*delta)
	get_input_for_rotate()
	if should_torque_be_applied!=0:
		pass
	cumulative_delta = cumulative_delta + delta
	if velocity.length()>0 and cumulative_delta>burn_speed_moving:
		cumulative_delta = 0
		emit_signal("oxygen_burn")
	elif velocity.length()==0 and cumulative_delta>burn_speed_idle:
		cumulative_delta = 0
		emit_signal("oxygen_burn")


func _process(delta):
	pass
