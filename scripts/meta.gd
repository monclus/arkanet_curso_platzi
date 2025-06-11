extends AnimatedSprite2D

@export var next_level: String
@onready var personaje := get_tree().get_nodes_in_group("Personaje")[0]
@onready var meta: AnimatedSprite2D = $"."
@onready var pos_antena: Marker2D = $PosAntena
@onready var pos_salida: Marker2D = $PosSalida
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var tween : Tween
var player_position: Vector2
var antena_position: Vector2
var salida_position: Vector2

func cinematica():
	Global.cinematica = true
	tween = meta.create_tween()
	player_position = personaje.global_position
	antena_position = pos_antena.global_position
	salida_position = pos_salida.global_position
	tween.tween_property(personaje, "global_position",antena_position,2.0)
	await tween.finished
	animation_player.play("Meta")
	await animation_player.animation_finished
	print(personaje.global_position, salida_position)
	tween = meta.create_tween()
	tween.tween_property(personaje, "global_position",salida_position,2.0)
	await tween.finished
	Global.cinematica = false
	get_tree().change_scene_to_file(next_level)
	
func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	cinematica()
