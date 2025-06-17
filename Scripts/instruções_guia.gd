extends Control

@onready var animation: AnimationPlayer = $Animation
@onready var explicação: Label = $"Background Explicação/Explicação"

var tipo = 0
var direção = 0
# 0 - esquerda
# 1 - direita
# 2 - cima
# 3 - baixo

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if (direção == null or direção > 3) or (tipo == null):
		queue_free()
	
	match direção:
		0:
			animation.play("Swipe Esquerda")
		1:
			animation.play("Swipe Direita")
		2:
			animation.play("Swipe Cima")
		3:
			animation.play("Swipe Baixo")
	match tipo:
		0:
			explicação.text = "Uma seta azul normalmente só defende ou ataca o inimigo, caso você erre o comando de qualquer seta ou demorar demais você leva dano"
		1:
			explicação.text = "Uma seta laranja prepara um ataque, dando mais tempo para o inimigo te atacar, mas logo depois vem uma seta azul que da dano no inimigo"
		2:
			explicação.text = "Uma seta cinza aponta pro lado errado, então o movimento tem que ser contrário"
		3:
			explicação.text = "Uma seta de coração é uma seta normal, mas te cura quando você acerta o comando"
		4:
			explicação.text = "Uma seta dupla tem que ser executada com dois dedos na direção mostrada"

func finished():
	Global.setasExplicadas[tipo] = true
	$"../Lista de Comandos".explicando = false
	$"../Lista de Comandos".checkArrow(direção, false)
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,0), 0.2)
	tween.connect("finished", queue_free)


func swipeCheck(directionIndx):
	if directionIndx == direção:
		finished()

func doubleSwipeCheck(directionIndx):
	if directionIndx == direção:
		finished()
