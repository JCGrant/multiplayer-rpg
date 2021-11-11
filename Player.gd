extends KinematicBody2D

export (int) var speed = 150

func _physics_process(_delta):
	var velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
		$Sprite.frame = 0
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		$Sprite.frame = 2
	if Input.is_action_pressed("down"):
		velocity.y += 1
		$Sprite.frame = 3
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		$Sprite.frame = 1
	velocity = velocity.normalized() * speed
	velocity = move_and_slide(velocity)
