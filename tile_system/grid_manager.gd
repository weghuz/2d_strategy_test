@tool
class_name TileManager
extends TileMap

@export var grid_size: Vector2 = Vector2(8, 8)
@export var tiles: Array[Vector2]

var tilemap: Array[Tile] = []
var focus = false;

# // INITIALIZATION
func _ready():
	seed_tiles()

func seed_tiles():
	for x in grid_size.x:
		for y in grid_size.y:
			var new_tile = Tile.new(Vector2(x, y), tiles, Tile.TILE.BLACK if int(x + y) % 2 == 0 else Tile.TILE.WHITE);
			tilemap.append(new_tile)
			draw_tile(new_tile)

			new_tile.tile_changed.connect(draw_tile)
			new_tile.tile_focused.connect(focus_tile)

# // STATE
func draw_tile(tile: Tile):
	set_cell(0, tile.position, 0, tile.tile)

func focus_tile(_tile: Tile):
	focus = true

# // GAME LOOP
func _input(event):
	if focus && event.is_pressed():
		focus = false
	elif focus:
		return

	var mouse_pos = get_global_mouse_position()
	var tile_pos = local_to_map(mouse_pos)
	for tile in tilemap:
		tile.handle_input(event, tile_pos)

# // UTILS
func get_tile(pos: Vector2) -> Tile:
	return tilemap[int(pos.x) * int(grid_size.x) + int(pos.y)]
