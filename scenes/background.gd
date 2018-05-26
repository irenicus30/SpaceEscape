extends Sprite

onready var bottle_scene = preload("res://scenes/bottle.tscn")
var tile_names = ["Wall1", "Wall2", "Wall3"]
export(int) var obstacles_on_screen
export(int) var bottles_on_screen

var no_x_region = 0
var max_no_x_region_so_far = 1
var screen_y_min
var screen_y_max

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	screen_y_min = region_rect.position.y
	screen_y_max = region_rect.end.y
	populate_with_obstacles(2*obstacles_on_screen-5,offset.x,offset.x+region_rect.end.x,screen_y_min,screen_y_max)
	populate_with_bottles(2*bottles_on_screen-1,offset.x,offset.x+region_rect.end.x,screen_y_min,screen_y_max)

func _process(delta):
    var astronaut = get_node("/root/background/astronaut")
    if astronaut.global_position.x > offset.x + 3*region_rect.end.x/4:
        no_x_region += 1
        if no_x_region>max_no_x_region_so_far:
            max_no_x_region_so_far = no_x_region
            populate_with_obstacles(obstacles_on_screen,offset.x+region_rect.end.x,offset.x+3*region_rect.end.x/2,screen_y_min,screen_y_max)
            populate_with_bottles(bottles_on_screen,offset.x+region_rect.end.x,offset.x+3*region_rect.end.x/2,screen_y_min,screen_y_max)
        offset.x += region_rect.end.x/2
    elif astronaut.global_position.x < offset.x + region_rect.end.x/4:
        no_x_region -= 1
        offset.x -= region_rect.end.x/2
    elif astronaut.global_position.y > offset.y + 3*region_rect.end.y/4:
        offset.y += region_rect.end.y/2
    elif astronaut.global_position.y < offset.y + region_rect.end.y/4:
        offset.y -= region_rect.end.y/2

func populate_with_obstacles(number_of_obstacles, pos_x_start, pos_x_end, pos_y_start, pos_y_end):
	for i in range(0,number_of_obstacles):
		var random_index = randi() % tile_names.size()
		var tilemap = get_node("/root/background/TileMap")
		var tile_index = tilemap.get_tileset().find_tile_by_name( tile_names[random_index] )
		
		var random_x = get_random_int_from_range(pos_x_start, pos_x_end)
		var random_y = get_random_int_from_range(pos_y_start, pos_y_end)
		while pos_y_start*2/3+pos_y_end/3<random_y and random_y<pos_y_start/3+pos_y_end*2/3:
			random_y = get_random_int_from_range(pos_y_start, pos_y_end)
		
		var tilemap_x = int(random_x/tilemap.cell_size.x)
		var tilemap_y = int(random_y/tilemap.cell_size.y)
		tilemap.set_cell(tilemap_x, tilemap_y, tile_index)

func populate_with_bottles(number_of_bottles, pos_x_start, pos_x_end, pos_y_start, pos_y_end):
	##remove_existing_bottles(pos_x_start, pos_x_end, pos_y_start, pos_y_end)
	for i in range(0,number_of_bottles):
		var bottle = bottle_scene.instance()
		bottle.position.x = get_random_int_from_range(pos_x_start, pos_x_end)
		bottle.position.y = get_random_int_from_range(pos_y_start*2/3+pos_y_end/3, pos_y_start/3+pos_y_end*2/3)
		get_node("/root/background/pickables").add_child(bottle)

func get_random_int_from_range(range_start, range_end):
	var difference = int(range_end-range_start)
	return int(range_start + randi() % difference)

func remove_existing_bottles(pos_x_start, pos_x_end, pos_y_start, pos_y_end):
	var pickables = get_node("/root/background/pickables")
	for child in pickables.get_children():
		if pos_x_start<=child.position.x and child.position.x<=pos_x_end:
			if pos_y_start<=child.position.y and child.position.y<=pos_y_end:
				child.queue_free()