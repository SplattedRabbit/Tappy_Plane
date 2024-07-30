extends Node2D

@export var pipes_scene: PackedScene
@onready var pipes_holder = $PipesHolder

@onready var spawn_u = $SpawnU
@onready var spawn_l = $SpawnL
@onready var spawn_timer = $SpawnTimer

@onready var plane = $Plane
@onready var main_music = $MainMusic

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_plane_died.connect(_on_plane_died)
	ScoreManager.set_score(0)
	
func spawnPipes() -> void:
	var new_pipes = pipes_scene.instantiate()
	var position_U = spawn_u.position.y - DifficultyScaling.position_upper
	var position_L = spawn_l.position.y + DifficultyScaling.position_lower 
	
	new_pipes.position = Vector2(spawn_u.position.x, randf_range(position_U, position_L))
	pipes_holder.add_child(new_pipes)

func stop_pipes() -> void:
	spawn_timer.stop()
	for pipe in pipes_holder.get_children():
		pipe.set_process(false)
	
func _on_spawn_timer_timeout():
	spawnPipes()
	
func _on_plane_died():
	main_music.stop()
	stop_pipes()
	print("You died!")
	
	
