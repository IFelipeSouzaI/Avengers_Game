extends Area2D

var motion = Vector2(1,1)
var speed = 300

func _ready():
	set_process(true)
	pass

func _process(delta):
	move(motion, delta, speed)
	if (global_position.y > 752 || global_position.y < -32) || (global_position.x > 452 || global_position.x < -32):
		queue_free()
	pass

func move(dir, delta, vel):
	move_local_x(dir.x*delta*vel)
	move_local_y(dir.y*delta*vel)
	pass

func _on_object_shot_body_entered(body):
	if body.is_in_group("Enemy"):
		body.damage(1+game.avenger_up[0])
		queue_free()
	pass
