extends CanvasLayer

@onready var menu_pausa: Control = $MenuPausa

func _on_pausa_pressed() -> void:
	get_tree().paused = true
	menu_pausa.visible = true

func _on_continuar_pressed() -> void:
	menu_pausa.visible = false
	get_tree().paused = false

func _on_salir_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/pantalla_principal.tscn")
