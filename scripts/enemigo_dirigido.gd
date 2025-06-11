extends Area2D

@export var direction : Vector2
@export var speed : int = 350
@onready var personaje = get_tree().get_nodes_in_group("Personaje")
@onready var posicion_personaje : Vector2
@export var valor_puntos : int = 100

var is_in_screen: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation = "idle"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_explotion():
	Global.añadir_puntos(valor_puntos)
	collision_mask = 0
	collision_layer = 0
	$AnimatedSprite2D.animation = "explosion"
	await $AnimatedSprite2D.animation_finished
	queue_free()
	
func _physics_process(delta: float) -> void:
	if is_in_screen:
		posicion_personaje = personaje[0].global_position
		global_position = global_position.move_toward(posicion_personaje, speed*delta)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	is_in_screen = true
