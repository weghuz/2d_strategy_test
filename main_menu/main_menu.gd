extends Control

func _on_start_game_button_pressed():
	get_tree().change_scene_to_file('res://level1.tscn')
	pass

func _on_settings_button_pressed():
	pass # Replace with function body.

func _on_exit_button_pressed():
	get_tree().quit()
