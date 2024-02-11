extends Resource
class_name Tile

@export var position: Vector2
@export var tile: Vector2

func _init(initial_position: Vector2, initial_tile: Vector2):
	position = initial_position
	tile = initial_tile

