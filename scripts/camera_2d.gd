extends Camera2D

@export var speed: int = 200

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !Global.pausa:
		if !Global.cinematica:
			position.x += speed * delta
