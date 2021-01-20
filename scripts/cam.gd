extends Camera2D

var can_shake = false
var amount = 0
var shake_time = []
var avenger = []

func _ready():
	set_process(true)
	pass

func _process(delta):
	if can_shake:
		var maior = 0
		for x in range(amount):
			if shake_time[x] > maior:
				maior = shake_time[x]
			shake_time[x] -= delta
		set_offset(Vector2(cos(rad2deg(maior))*3, (sin(rad2deg(maior))*3)))
		can_shake = false
		for x in range(amount):
			if shake_time[x] > 0:
				can_shake = true
			else:
				if avenger[x] != 10 && avenger[x] != 1:
					game.avenger_anchor[avenger[x]] = 2
					avenger[x] = 10
	else:
		shake_time = null
		avenger = null
		shake_time = []
		avenger = []
		amount = 0
		set_offset(Vector2(0,0))

func shake(valor, anchor = 10):
	can_shake = true
	amount += 1
	avenger.append(anchor)
	shake_time.append(valor)
	pass