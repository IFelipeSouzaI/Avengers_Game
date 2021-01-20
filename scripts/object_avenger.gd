extends Node2D

var anim
export var avenger = 0
var avenger_time = [5, 25, 30, 50, 20, 20]
var avenger_path = ["res://sprites/avengers/Capitao.png",
"res://sprites/avengers/IronMan.png",
"res://sprites/avengers/Hulk.png",
"res://sprites/avengers/Thor.png",
"res://sprites/avengers/Gaviao.png",
"res://sprites/avengers/Viuva.png"]

var attack_path = [preload("res://scenes/objects/object_shield.tscn"), 
preload("res://scenes/objects/object_armorAttack.tscn"),
preload("res://scenes/objects/object_hulkSmash.tscn"), 
preload("res://scenes/objects/object_thorThunder.tscn"),
preload("res://scenes/objects/object_arrowSpaner.tscn"),
preload("res://scenes/objects/object_bulletSpawner.tscn")]
var attack_charged = false
var attack_pos = [Vector2(8,4), Vector2(0,-24), Vector2(0,0), Vector2(0,0), Vector2(9,16), Vector2(0,16)]

func _ready():
	$spcBar.max_value = avenger_time[avenger]
	$pos.position = attack_pos[avenger]
	$sprite.texture = load(avenger_path[avenger])
	$timer.wait_time = avenger_time[avenger]
	$timer.start()
	set_process(true)
	pass

func _process(delta):
	if !game.over:
		if attack_charged:
			$spcBar.value = 0
			animP("attack"+str(avenger))
			game.avenger_anchor[avenger] = 1
			attack_charged = false
		else:
			if game.avenger_anchor[avenger] == 0:
				$spcBar.value = avenger_time[avenger]-$timer.time_left
				animP("idle")
			elif game.avenger_anchor[avenger] == 2:
				animP("back"+str(avenger))
	else:
		animP("dead")
	pass

func animP(new_anim):
	if anim != new_anim:
		anim = new_anim
		$anim.play(anim)
	pass

func a_instance():
	var a = attack_path[avenger].instance()
	if avenger != 3:
		a.position = $pos.position
	add_child(a)
	pass

func anim_back():
	game.avenger_anchor[avenger] = 0
	$timer.wait_time = avenger_time[avenger]
	$timer.start()
	pass