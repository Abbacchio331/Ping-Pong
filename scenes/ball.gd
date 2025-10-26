extends Area2D

class_name Ball

@onready var rocket_sound: AudioStreamPlayer2D = $"../rocket_sound"
@onready var table_sound: AudioStreamPlayer2D = $"../table_sound"

@export var direction: float = 0.0
var speed: float = 200.0
const TOP_Y: float = 103.0
const DOWN_Y: float = 563.0
const MAX_SPREAD: float = 25.0
const MAX_BALL_SPEED = 800.0
var target_min: float
var target_max: float
var played_table_sound: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Translate direction and speed to position
	if speed and speed > 0:
		var direction_vector = Vector2.from_angle(deg_to_rad(direction))
		var direction_change = direction_vector * speed * delta
		position += direction_change
	# Play table sound
	if not played_table_sound and (
		(direction > 90 and direction < 270 and position.x < 476) or 
		((direction < 90 or direction > 270) and position.x > 676)
	):
		played_table_sound = true
		table_sound.play()
		


func _on_area_entered(_area: Area2D) -> void:
	# Gradually increase speed
	if speed < MAX_BALL_SPEED:
		speed *= 1.1
	# Play rocket sound and reset table sound
	rocket_sound.play(0.2)
	played_table_sound = false
	calculate_direction()
	
func calculate_direction() -> void:	
	var viewport_center_x: float = get_viewport_rect().size.x / 2.0
	var horizontal_side: int = 1 if position.x > viewport_center_x else -1
	var current_y: float = global_position.y
	# print("CURRENT Y:", current_y)
	var y_side_position_level: float = (current_y - TOP_Y) / (DOWN_Y - TOP_Y)
	# print("CURRENT Y LEVEL:", y_side_position_level)
	if horizontal_side == -1:
		target_min = -1 * y_side_position_level * MAX_SPREAD
		target_max = (1 - y_side_position_level) * MAX_SPREAD
	else:
		target_min = 180 - (1 - y_side_position_level) * MAX_SPREAD
		target_max = 180 + y_side_position_level * MAX_SPREAD
	# print("TARGET MIN:", target_min)
	# print("TARGET MAX:", target_max)
	direction = randf_range(target_min, target_max)
	# print("CALCULATED DIRECTION:", direction)
	
