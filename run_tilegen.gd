@tool
extends EditorScript

# Called when the node enters the scene tree for the first time.
func _run():
	var tilemap = get_scene().get_node("%TileMap")
	tilemap.seed_tiles()
	#var tilemap = get_scene().find_child("%TileMap")
	#tilemap.seed_tiles()
	
