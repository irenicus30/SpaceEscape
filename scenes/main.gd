extends Sprite

onready var bottle_scene = preload("res://scenes/bottle.tscn")
onready var bgsprite_scene = preload("res://scenes/bgsprite.tscn")
var tile_names = ["Wall1", "Wall2", "Wall3", "Wall4", "Wall5", "Wall6", "Wall7"]
export(int) var obstacles_on_screen
export(int) var bottles_on_screen

var no_x_region = 0
var max_no_x_region_so_far = 0
var background_y_min = 0
var background_y_max = 2048
var background_x_min = 0
var background_x_max = 2048
var background_width = 2048 # same as texture width, we use it to generate textures

var bgsprites = []


func _ready():
	var rect = [background_x_min,background_x_max+background_width,background_y_min,background_y_max]
	populate_with_obstacles(4*obstacles_on_screen-5,rect)
	populate_with_bottles(4*bottles_on_screen-1,rect)
	bgsprites.append(get_node("/root/main/background/bgsprite0"))
	bgsprites.append(get_node("/root/main/background/bgsprite1"))
	bgsprites.append(get_node("/root/main/background/bgsprite2"))

func _process(delta):
    var astronaut = get_node("/root/main/astronaut")
    if astronaut.global_position.x > background_x_max+no_x_region*background_width:
        no_x_region += 1
        if no_x_region>max_no_x_region_so_far:
            max_no_x_region_so_far = no_x_region
            var rect = [background_x_min+no_x_region*background_width+background_width,background_x_max+no_x_region*background_width+background_width,background_y_min,background_y_max]
            populate_with_obstacles(obstacles_on_screen,rect)
            populate_with_bottles(bottles_on_screen,rect)
            add_texture(no_x_region*background_width+background_width)
    elif astronaut.global_position.x < background_x_min+no_x_region*background_width:
        no_x_region -= 1

func populate_with_obstacles(number_of_obstacles, rect):
	var pos_x_start = rect[0]
	var pos_x_end = rect[1]
	var pos_y_start = rect[2]
	var pos_y_end = rect[3]
	for i in range(0,number_of_obstacles):
		var random_index = randi() % tile_names.size()
		var tilemap = get_node("/root/main/TileMap")
		var tile_index = tilemap.get_tileset().find_tile_by_name( tile_names[random_index] )

		var random_x = get_random_int_from_range(pos_x_start, pos_x_end)
		var random_y = get_random_int_from_range(pos_y_start, pos_y_end)
		while pos_y_start*2/3+pos_y_end/3<random_y and random_y<pos_y_start/3+pos_y_end*2/3:
			random_y = get_random_int_from_range(pos_y_start, pos_y_end)

		var tilemap_x = int(random_x/tilemap.cell_size.x)
		var tilemap_y = int(random_y/tilemap.cell_size.y)
		tilemap.set_cell(tilemap_x, tilemap_y, tile_index)

func populate_with_bottles(number_of_bottles, rect):
	var pos_x_start = rect[0]
	var pos_x_end = rect[1]
	var pos_y_start = rect[2]
	var pos_y_end = rect[3]
	##remove_existing_bottles(pos_x_start, pos_x_end, pos_y_start, pos_y_end)
	for i in range(0,number_of_bottles):
		var bottle = bottle_scene.instance()
		bottle.position.x = get_random_int_from_range(pos_x_start, pos_x_end)
		bottle.position.y = get_random_int_from_range(pos_y_start*2/3+pos_y_end/3, pos_y_start/3+pos_y_end*2/3)
		get_node("/root/main/pickables").add_child(bottle)

func get_random_int_from_range(range_start, range_end):
	var difference = int(range_end-range_start)
	return int(range_start + randi() % difference)

##func remove_existing_bottles(pos_x_start, pos_x_end, pos_y_start, pos_y_end):
##	var pickables = get_node("/root/main/pickables")
##	for child in pickables.get_children():
##		if pos_x_start<=child.position.x and child.position.x<=pos_x_end:
##			if pos_y_start<=child.position.y and child.position.y<=pos_y_end:
##				child.queue_free()
func add_texture(offset_x):
	var bgsprite = bgsprite_scene.instance()
	bgsprite.offset.x = offset_x
	get_node("/root/main/background").add_child(bgsprite)