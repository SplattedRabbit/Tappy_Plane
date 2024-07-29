extends CharacterBody2D

signal on_plane_died

const GRAVITY: float = 1500.00
const POWER: float = -500

@onready var flying_plane: AnimatedSprite2D = $Sprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var engine_sound = $EngineSound


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	falling_speed(delta)
	fly()
	move_and_slide()
	if (is_on_floor() == true):
		die()
		
func falling_speed(delta: float) -> void:
	velocity.y += GRAVITY * delta
	
		
func fly() -> void:
	if (Input.is_action_just_pressed("fly") == true):
		velocity.y = POWER
		animation_player.play("power")

func die() -> void:
	animation_player.play("plane_dies")
	flying_plane.stop()
	engine_sound.stop()
	set_physics_process(false)
	SignalManager.on_plane_died.emit()
	
