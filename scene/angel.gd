extends CharacterBody2D

var SPEED = 300.0
const JUMP_VELOCITY = -700.0
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var staminabar: ProgressBar = $"../ui/staminabar"
@onready var player_sound: AudioStreamPlayer2D = $playerSound

@export var inventory: Inv

# Store the last facing direction
var last_facing_left = false

var stamina = 10

func _on_add_stamina_pressed():
	stamina += 1
	staminabar.value = stamina

func _on_subtract_stamina_pressed():
	stamina -= 1
	staminabar.value = stamina

func _physics_process(delta: float) -> void:
	# Animation
	if abs(velocity.x) > 1:
		sprite_2d.animation = "walking"
		if not player_sound.playing && is_on_floor():
			player_sound.play()
	else:
		sprite_2d.animation = "default"
		if player_sound.playing:
			player_sound.stop()

	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle movement/deceleration
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		# Update last facing direction
		last_facing_left = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Apply last facing direction when stopped
	sprite_2d.flip_h = last_facing_left

	# Move the character
	move_and_slide()

func _ready():
	staminabar.value = stamina
