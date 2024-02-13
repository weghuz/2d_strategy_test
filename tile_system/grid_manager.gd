@tool
class_name TileManager
extends TileMap

@export var grid_size: Vector2 = Vector2(8, 8)

enum {WHITE, BLACK, BALL, BALL2}
@export var tiles: Array[Vector2]
var current_tilemap: Array[Tile] = []

var last_tile: Tile
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
	set_cell(0, pos, 0, tile)

func draw_tiles():
	for tile in current_tilemap:
		draw_tile(tile.position, tile.tile)

func _input(event):
	if event is InputEventMouseButton && event.is_pressed():
		var mouse_pos = get_global_mouse_position()
		var tile_pos = local_to_map(mouse_pos)
		if tile_pos.x < grid_size.x && tile_pos.y < grid_size.y:
			set_tile(Tile.new(tile_pos, tiles[BALL2]))
			draw_tiles()
	elif event is InputEventMouseMotion:
		var mouse_pos = get_global_mouse_position()
		var tile_pos = local_to_map(mouse_pos)
		if tile_pos.x < grid_size.x && tile_pos.y < grid_size.y:
			if get_tile(tile_pos).tile == tiles[BALL2]:
				return
			reset_last_tile()
			set_last_tile(tile_pos)
			set_tile(Tile.new(tile_pos, tiles[BALL]))
			draw_tiles()
		else:
			reset_last_tile()
			draw_tiles()
			
func reset_last_tile():
	if(last_tile_set && get_tile(last_tile.position).tile != tiles[BALL2]):
		set_tile(last_tile)

func set_last_tile(new_position: Vector2):
	last_tile = Tile.new(new_position, get_tile(new_position).tile)
	last_tile_set = true

func get_tile(tile_position: Vector2):
	var index = (tile_position.x * grid_size.x) + tile_position.y;
	if current_tilemap.size() >= index:
		return current_tilemap[index]
	return null

func set_tile(new_tile: Tile):
	current_tilemap[(new_tile.position.x * grid_size.x) + new_tile.position.y] = new_tile
