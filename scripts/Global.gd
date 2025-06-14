extends Node

var health: int = 3
var puntos: int = 0
var valor: int = 0
var Label_puntos: Label
var cinematica: bool = false
var pausa: bool = false
#@onready var Display_Puntos : Label = get_tree().root.get_child("Label")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pausa"):
		pausa = not pausa

func quitar_vidas() -> void:
	if health > 1:
		health -= 1
		#print("Vida:" +  str(health))
	else:
		get_tree().reload_current_scene()
		
func añadir_puntos(valor: int) -> void:
	#print("Puntos:" +  str(puntos))
	puntos += valor
	Label_puntos.text = str(puntos)
