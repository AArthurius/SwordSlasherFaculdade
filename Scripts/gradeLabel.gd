extends Label

var centro := Vector2()
var tempo := 0.0
var raio := Vector2(8, 5)  # quão largo e alto é o movimento

var glide:bool = false

func _ready():
	centro = position  # ponto base do movimento

func _process(delta):
	if !glide:
		position = centro
		return 
	tempo += delta * 5.0  # velocidade do movimento
	position = centro + Vector2(
		cos(tempo) * raio.x,
		sin(tempo * 1.5) * raio.y
	)
