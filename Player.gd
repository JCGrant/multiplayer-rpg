extends KinematicBody2D

var id

export (int) var speed = 150

var target_position = position

func _physics_process(_delta):
	var velocity = Vector2()
	if Network.is_local_player(id):
		if Input.is_action_pressed("right"):
			velocity.x += 1
		if Input.is_action_pressed("left"):
			velocity.x -= 1
		if Input.is_action_pressed("down"):
			velocity.y += 1
		if Input.is_action_pressed("up"):
			velocity.y -= 1
		velocity = velocity.normalized() * speed
		velocity = move_and_slide(velocity, Vector2.UP)
		Network.send("MOVE_PLAYER", {"position": position})
	else:
		velocity = target_position - position
		$Tween.interpolate_property(self, "position", position, target_position, 0.3)
		$Tween.start()

	if velocity.x > 0.1:
		$Sprite.frame = 0
	if velocity.x < -0.1:
		$Sprite.frame = 2
	if velocity.y > 0.1:
		$Sprite.frame = 3
	if velocity.y < -0.1:
		$Sprite.frame = 1
