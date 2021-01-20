extends Node2D

var pre_fire = false
var bullet = preload("res://scenes/objects/object_shot.tscn")
export var sound_control = false

func _ready():
	set_process_input(true)
	pass

func _input(event):
	if game.wave_time and !game.over:
		if event is InputEventScreenTouch:
			if ((event.position.y > 300) || (event.position.y <= 300 and event.position.x > 130 and event.position.x < 280 and event.position.y > 135)):
				if event.pressed:
					pre_fire = true
					$sprite.look_at(event.position)
				elif pre_fire:
					pre_fire = false
					var motion = (Vector2($sprite/out.global_position.x - global_position.x, $sprite/out.global_position.y - global_position.y)).normalized()
					$anim.play("shot")
					b_instance(motion)
		elif event is InputEventScreenDrag:
			if ((event.position.y > 300) || (event.position.y <= 300 and event.position.x > 130 and event.position.x < 280 and event.position.y > 135)):
				if pre_fire:
					$sprite.look_at(event.position)
	pass

func b_instance(motion):
	if sound_control:
		object_audioPlayer.play_song(8)
	var b = bullet.instance()
	b.position = $sprite/out.global_position
	b.motion = motion
	get_parent().add_child(b)
	pass

