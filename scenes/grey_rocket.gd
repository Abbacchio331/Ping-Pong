extends Area2D

var rocket_speed: int = 400
var movement_direction: float = 0.0 
var movement: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_movement(delta)

func handle_movement(delta: float) -> void:
	if Input.is_action_pressed("grey_up") or Input.is_action_pressed("grey_down"):
		movement_direction = Input.get_axis("grey_up", "grey_down")
		movement = position.y + movement_direction * rocket_speed * delta
		position.y = clampf(movement, 103.0, 563.0)
