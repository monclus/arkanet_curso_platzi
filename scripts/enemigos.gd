extends Area2D

@export var valor_puntos : int = 50

func set_explotion():
	Global.añadir_puntos(valor_puntos)
	collision_mask = 0
	collision_layer = 0
	$AnimatedSprite2D.animation = "explosion"
	await $AnimatedSprite2D.animation_finished
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
