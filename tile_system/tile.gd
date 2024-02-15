extends Resource
class_name Tile

enum TILE {WHITE, BLACK, BALL, BALL2}
@export var position: Vector2
@export var tile: Vector2
@export var tiles: Array[Vector2]
var initial_tile

signal tile_changed(tile: Tile)
signal tile_focused(tile: Tile)

func _init(initial_position: Vector2, initial_tiles: Array[Vector2], new_tile: TILE):
	tiles = initial_tiles;
	position = initial_position
	tile = tiles[new_tile]
	initial_tile = tile;

func handle_input(event: InputEvent, mouse_tile_pos: Vector2):
	if mouse_tile_pos == position:
		if event.is_pressed():
			tile = tiles[TILE.BALL2]
			tile_focused.emit(self)
		else:
			tile = tiles[TILE.BALL]		
		tile_changed.emit(self)
	else:
		tile = initial_tile
		tile_changed.emit(self)
