extends Path2D

@export var tamaño_enemigos : int = 1
@export var speed : int = 200
@onready var recorridos : Array[Node] = get_children()
var is_in_screen: bool = false
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_in_screen:
		for recorrido : Node in recorridos:
			if recorrido.get_class() == "PathFollow2D":
				recorrido.progress += speed*delta
	
func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	is_in_screen = true
