extends Control

var tempo := 0.0

func _process(delta):
	tempo += delta * 1.5 # velocidade da animação

	# Gera cor com base no tempo usando HSV (Hue, Saturation, Value)
	var cor = Color.from_hsv(fmod(tempo, 1.0), 1.0, 1.0)
	self.modulate = cor
