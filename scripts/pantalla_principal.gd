extends Control

func _on_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/nivel_1.tscn")

func _on_salir_pressed() -> void:
	get_tree().quit()
