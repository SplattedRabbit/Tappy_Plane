extends Control

@onready var pr_space = $PR_Space
@onready var go_label = $GO_LABEL
@onready var gameover = $gameover


@onready var deathtimer = $deathtimer

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	SignalManager.on_plane_died.connect(on_plane_died)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pr_space.visible == true && (Input.is_action_just_pressed("fly") == true):
		GameManager.load_main_scene()
		
func on_plane_died() -> void:
	gameover.play()
	show()
	deathtimer.start()

func _switchLabels() -> void:
	go_label.hide()
	pr_space.show()

func _on_deathtimer_timeout():
	_switchLabels()
