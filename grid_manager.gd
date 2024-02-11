class_name GridManager
extends TileMap

@export var grid_size: Vector2 = Vector2(6, 6)
@export var black_tile: Vector2 = Vector2(12, 0)
@export var white_tile: Vector2 = Vector2(12, 1)
@export var ball: Vector2 = Vector2(20, 16)

enum {WHITE, BLACK, BALL}
var tiles: Array[Vector2] = [black_tile,white_tile,ball]
var current_tilemap: Array[Tile] = []

var last_tile_position: Vector2
var last_tile_type: Vector2
var last_tile_set: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	seed_tiles()
	draw_tiles()
	pass # Replace with function body.

func seed_tiles():
	for x in grid_size.x:
		for y in grid_size.y:
			if int(x) % 2 == int(y) % 2:
				current_tilemap.append(Tile.new(Vector2(x, y), tiles[WHITE]))
				continue
			current_tilemap.append(Tile.new(Vector2(x, y), tiles[BLACK]))

func draw_tile(pos: Vector2, tile: Vector2):
	if(pos == Vector2.ZERO):
		print(pos, tile)
	set_cell(0, pos, 0, tile)

func draw_tiles():
	for tile in current_tilemap:
		draw_tile(tile.position, tile.tile)
		#if tile.tile != tiles[WHITE] && tile.tile != tiles[BLACK]:

func _input(event):
	if event is InputEventMouseMotion:
		var mouse_pos = get_global_mouse_position()
		var tile_pos = local_to_map(mouse_pos)
		if tile_pos.x < grid_size.x && tile_pos.y < grid_size.y:
			reset_last_tile()
			set_last_tile(tile_pos)
			set_tile(tile_pos, tiles[BALL])
			draw_tiles()
		else:
			reset_last_tile()
			draw_tiles()
			
func reset_last_tile():
	if(last_tile_set):
		set_tile(last_tile_position, last_tile_type)

func set_last_tile(new_position: Vector2):
	last_tile_type = get_tile(new_position).tile
	last_tile_position = new_position
	last_tile_set = true

func get_tile(position: Vector2):
	var index = (position.x * grid_size.x) + position.y;
	if current_tilemap.size() >= index:
		return current_tilemap[index]
	return null

func set_tile(new_position: Vector2, new_tile: Vector2):
	current_tilemap[(new_position.x * grid_size.x) + new_position.y] = Tile.new(new_position, new_tile)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
