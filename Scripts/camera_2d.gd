extends Camera3D

var swipe_length = 30
var fingers_start = {}  # Armazena posição inicial de cada dedo
var fingers_current = {}  # Armazena posição atual de cada dedo
var active_fingers = []

signal Swipe(directionIndex)
signal DoubleSwipe(directionIndex)

func _input(event):
	# Toque começou
	if event is InputEventScreenTouch:
		if event.pressed:
			fingers_start[event.index] = event.position
			fingers_current[event.index] = event.position
			if event.index not in active_fingers:
				active_fingers.append(event.index)
		else:
			fingers_start.erase(event.index)
			fingers_current.erase(event.index)
			active_fingers.erase(event.index)

	# Movimento do dedo
	elif event is InputEventScreenDrag:
		if event.index in fingers_start:
			fingers_current[event.index] = event.position

	# Verificar swipes quando há exatamente dois dedos ativos
	if active_fingers.size() == 2:
		var index1 = active_fingers[0]
		var index2 = active_fingers[1]

		var delta1 = fingers_current[index1] - fingers_start[index1]
		var delta2 = fingers_current[index2] - fingers_start[index2]

		if delta1.length() >= swipe_length and delta2.length() >= swipe_length:
			var dir1 = get_swipe_direction(delta1)
			var dir2 = get_swipe_direction(delta2)

			if dir1 == dir2:
				emit_signal("DoubleSwipe", dir1)
				# Limpar os dados para evitar múltiplos disparos
				fingers_start.clear()
				fingers_current.clear()
				active_fingers.clear()
			else:
				# Caso não estejam na mesma direção, não faz nada ainda
				pass

	# Também pode emitir swipes únicos
	elif active_fingers.size() == 1:
		var index = active_fingers[0]
		var delta = fingers_current[index] - fingers_start[index]
		if delta.length() >= swipe_length:
			var dir = get_swipe_direction(delta)
			emit_signal("Swipe", dir)
			fingers_start.clear()
			fingers_current.clear()
			active_fingers.clear()

func get_swipe_direction(delta: Vector2) -> int:
	if abs(delta.x) > abs(delta.y):
		return 0 if delta.x < 0 else 1  # Esquerda / Direita
	else:
		return 2 if delta.y < 0 else 3  # Cima / Baixo
