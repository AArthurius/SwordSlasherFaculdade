extends Camera3D

var length = 30
var startPos: Vector2
var curPos: Vector2
var swiping = false
var threshold = 5

signal Swipe(directionIndex)

func _input(event):
	# Detectar toque inicial
	if event is InputEventScreenTouch:
		if event.pressed and not swiping:
			swiping = true
			startPos = event.position
		elif not event.pressed:
			swiping = false  # Resetar quando o toque é solto
	
	# Detectar arrasto (swipe)
	if event is InputEventScreenDrag and swiping:
		curPos = event.position
		var delta = curPos - startPos
		# Verifica se o swipe atingiu o comprimento mínimo
		if delta.length() >= length:
			if abs(delta.y) <= abs(delta.x):
				emit_signal("Swipe", 0 if delta.x < 0 else 1)  # Esquerda / Direita
			elif abs(delta.x) <= abs(delta.y):
				emit_signal("Swipe", 2 if delta.y < 0 else 3)  # Cima / Baixo
			
			swiping = false  # Impedir múltiplos disparos para um único swipe
