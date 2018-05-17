extends Sprite

onready var bottle_scene = preload("res://scenes/bottle.tscn")
export(int) var bottles_on_screen


# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	populate_with_bottles(bottles_on_screen*4-1,offset.x,offset.x+region_rect.end.x,offset.y,offset.y+region_rect.end.y)

func _process(delta):
    var astronaut = get_node("/root/background/astronaut")
    if astronaut.global_position.x > offset.x + 3*region_rect.end.x/4:
        populate_with_bottles(bottles_on_screen*2,offset.x+region_rect.end.x,offset.x+3*region_rect.end.x/2,offset.y,offset.y+region_rect.end.y)
        offset.x += region_rect.end.x/2
    elif astronaut.global_position.x < offset.x + region_rect.end.x/4:
        populate_with_bottles(bottles_on_screen*2,offset.x-region_rect.end.x/2,offset.x,offset.y,offset.y+region_rect.end.y)
        offset.x -= region_rect.end.x/2
    elif astronaut.global_position.y > offset.y + 3*region_rect.end.y/4:
        populate_with_bottles(bottles_on_screen*2,offset.x,offset.x+region_rect.end.x,offset.y+region_rect.end.y,offset.y+3*region_rect.end.y/2)
        offset.y += region_rect.end.y/2
    elif astronaut.global_position.y < offset.y + region_rect.end.y/4:
        populate_with_bottles(bottles_on_screen*2,offset.x,offset.x+region_rect.end.x,offset.y-region_rect.end.y/2,offset.y)
        offset.y -= region_rect.end.y/2

	
func populate_with_bottles(number_of_bottles, pos_x_start, pos_x_end, pos_y_start, pos_y_end):
	for i in range(0,number_of_bottles):
		var bottle = bottle_scene.instance()
		bottle.position.x = get_random_int_from_range(pos_x_start, pos_x_end)
		bottle.position.y = get_random_int_from_range(pos_y_start, pos_y_end)
		get_node("/root/background/pickables").add_child(bottle)

func get_random_int_from_range(range_start, range_end):
	var difference = int(range_end-range_start)
	return int(range_start + randi() % difference)