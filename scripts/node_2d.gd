extends Node2D

@onready var boton_ataque: TouchScreenButton = $BotonAtaque

func _on_boton_ataque_pressed() -> void:
	boton_ataque.self_modulate = Color(1,1,1,0.6)

func _on_boton_ataque_released() -> void:
	boton_ataque.self_modulate = Color(1,1,1,1)
