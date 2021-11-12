extends Node2D

var player_scene= preload("res://../Player.tscn")

func _ready():
	visible = false

func setup_state(state):
	for player_id in state.players:
		var player = state.players[player_id]
		spawn_player(player_id, player)
	visible = true

func spawn_player(player_id, player):
	var new_player = player_scene.instance()
	new_player.id = player_id
	new_player.name = str(player_id)
	new_player.position = player.position
	if Network.is_local_player(player_id):
		var camera = Camera2D.new()
		camera.current = true
		camera.zoom = Vector2(0.3, 0.3)
		new_player.add_child(camera)
	else:
		new_player.modulate = Color("94ffdf")
	$YSort/Players.add_child(new_player)

func despawn_player(player_id):
	_get_player(player_id).queue_free()

func move_player(player_id, position):
	_get_player(player_id).target_position = position

func _get_player(player_id):
	return get_node("YSort/Players/" + str(player_id))
