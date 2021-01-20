extends Area2D

var speed = 400

func _ready():
	set_process(true)
	pass

func _process(delta):
	move_local_y(speed*delta)
	if global_position.y > 720:
		queue_free()
	pass

func _on_object_bullet_body_entered(body):
	if body.is_in_group("Enemy"):
		body.damage(1+game.avenger_up[6])
		queue_free()
	pass
