extends RigidBody2D

signal oxygen_burn

export (int) var speed = 100
export (float) var burn_speed_moving = 0.1
export (float) var burn_speed_idle = 0.3

var cumulative_delta = 0
var velocity = Vector2()
var MAX_SPEED = 105

func _ready():
	var GUI = get_node("/root/main/CanvasLayer/GUI")
	connect("oxygen_burn", GUI, "on_oxygen_burn")

func get_input():
    velocity = Vector2()
    if Input.is_action_pressed('ui_right'):
        if velocity.x <= MAX_SPEED:
            velocity.x += 1
    if Input.is_action_pressed('ui_left'):
        velocity.x -= 1
    if Input.is_action_pressed('ui_down'):
        velocity.y += 1
    if Input.is_action_pressed('ui_up'):
        velocity.y -= 1
    if velocity.length()>0:
        velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	apply_impulse(Vector2(), velocity*delta)
	cumulative_delta = cumulative_delta + delta
	if velocity.length()>0 and cumulative_delta>burn_speed_moving:
		cumulative_delta = 0
		emit_signal("oxygen_burn")
	elif velocity.length()==0 and cumulative_delta>burn_speed_idle:
		cumulative_delta = 0
		emit_signal("oxygen_burn")


func _process(delta):
	pass
