extends Node2D

@onready var ball: Ball = $Ball
@onready var red_rocket: Area2D = $"Red Rocket"
@onready var grey_rocket: Area2D = $"Grey Rocket"
@onready var game_over_text: Label = $"Game Over TEXT"
@onready var synthwave_loop: AudioStreamPlayer2D = $synthwave_loop
@onready var win_sound: AudioStreamPlayer2D = $win_sound

var playing: bool = true

func game_over(winner: String) -> void:
	playing = false
	stop_all()
	synthwave_loop.stop()
	win_sound.play()
	game_over_text.text = winner + " won!"
	game_over_text.visible_ratio = 1.0
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Random side starts
	ball.direction = float(randi_range(0, 1)) * 180.0
	game_over_text.visible_ratio = 0.0
	
	
func stop_all() -> void:
	red_rocket.set_process(false)
	grey_rocket.set_process(false)
	ball.set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if ball.position.x < -20 and playing:
		game_over("Grey Rocket")
	elif ball.position.x > get_viewport_rect().size.x + 20 and playing:
		game_over("Red Rocket")
		
		
		
# Sounds: Table & Rocket Sound Effect by <a href="https://pixabay.com/users/freesound_community-46691455/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=23500">freesound_community</a> from <a href="https://pixabay.com/sound-effects//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=23500">Pixabay</a>
# BG Sound Effect by <a href="https://pixabay.com/users/freesound_community-46691455/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=22508">freesound_community</a> from <a href="https://pixabay.com/sound-effects//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=22508">Pixabay</a>
# WIN Sound Effect by <a href="https://pixabay.com/users/xmersounds-50703818/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=416829">Xmer™ Sounds</a> from <a href="https://pixabay.com//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=416829">Pixabay</a>
