extends Camera2D

var player: KinematicBody2D

func _ready():
	player = get_node("../Player")

func _physics_process(_delta):
	position.x = floor(player.position.x)
	position.y = floor(player.position.y)
	force_update_scroll()
