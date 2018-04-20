extends KinematicBody2D

export (int) var speed = 500

var velocity = Vector2()

func get_input():
    velocity = Vector2()
    if Input.is_action_pressed('ui_right'):
        velocity.x += 1
    if Input.is_action_pressed('ui_left'):
        velocity.x -= 1
    if Input.is_action_pressed('ui_down'):
        velocity.y += 1
    if Input.is_action_pressed('ui_up'):
        velocity.y -= 1
    velocity = velocity.normalized() * speed

func _physics_process(delta):
    get_input()
    move_and_slide(velocity)
    print(velocity)

func _process(delta):
    var background = get_parent()
    if global_position.x > background.offset.x + background.region_rect.end.x/4:
        background.offset.x += background.region_rect.end.x/2
    elif global_position.x < background.offset.x - background.region_rect.end.x/4:
        background.offset.x -= background.region_rect.end.x/2
    elif global_position.y > background.offset.y + background.region_rect.end.y/4:
        background.offset.y += background.region_rect.end.y/2
    elif global_position.y < background.offset.y - background.region_rect.end.y/4:
        background.offset.y -= background.region_rect.end.y/2
