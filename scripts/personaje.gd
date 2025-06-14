extends CharacterBody2D

@export var direction : Vector2
@export var speed : int = 400
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var enfriamiento: Timer = $Enfriamiento
@onready var HUD : Node = get_tree().get_nodes_in_group("HUD")[0]
@onready var disparo : Resource= preload("res://scenes/Disparo.tscn")
@onready var disparo_especial : Resource = preload("res://scenes/disparo_especial.tscn")
@onready var power_up: bool = false
@onready var bus_index : int = AudioServer.get_bus_index("BGM")
@onready var audio_effect : AudioEffect = AudioServer.get_bus_effect(bus_index, 0)

func _ready() -> void:
	audio_effect["pitch_scale"] = 1
	#AudioServer.get_bus_effect(bus_index, )
	Global.health = 3
	Global.puntos = 0
	Global.Label_puntos = HUD.get_node("BarraPuntos/Puntos")
	Global.añadir_puntos(0)
	
func _process(delta: float) -> void:
	if power_up:
		animation_tree["parameters/StateMachine/conditions/got_power"] = true
		audio_effect["pitch_scale"] = 2

func _get_inputs() -> void:
	velocity = Input.get_vector("move_backward","move_forward","move_up","move_down") * speed
	if Input.is_action_pressed("attack"):
		_shoot()
		
func _physics_process(delta: float) -> void:
	if !Global.cinematica:
		_get_inputs()
		animation_tree["parameters/Anim_Movimiento/blend_position"] = velocity.normalized()
		move_and_slide()

func _shoot() -> void:
	if enfriamiento.is_stopped():
		enfriamiento.start()
		var instancia_disparo : Node
		if power_up:
			instancia_disparo = disparo_especial.instantiate()
		else:
			instancia_disparo = disparo.instantiate()
		instancia_disparo.position = $Arma.global_position
		add_child(instancia_disparo)
		$AudioDisparo.play()
		instancia_disparo.set_as_top_level(true)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemigos"):
		_take_damage()
		area.set_explotion()

func _take_damage() -> void:
	Global.quitar_vidas()
	var barra_vida: Node = HUD.get_node("BarraVida")
	var vidas: Array = barra_vida.get_children()
	vidas[Global.health].visible = false
	animation_tree["parameters/StateMachine/conditions/got_damaged"] = true
	
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "damaged":
		animation_tree["parameters/StateMachine/conditions/got_damaged"] = false
	if anim_name == "power_up":
		power_up = false
		audio_effect["pitch_scale"] = 1
		animation_tree["parameters/StateMachine/conditions/got_power"] = false

func _on_enfriamiento_timeout() -> void:
	enfriamiento.stop()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_class() == "TileMapLayer":
		_take_damage()
