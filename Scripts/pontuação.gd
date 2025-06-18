extends Control

@onready var label: Label = $Label
@onready var tempo_de_reação: Timer = $"../Tempo de reação Label/Tempo de reação"

func _ready() -> void:
	checkDificuldade()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = str(Global.pontuaçãoAtual)

func checkDificuldade():
	if Global.nivelDificuldade == 0:
		tempo_de_reação.wait_time = 2.5
	elif Global.nivelDificuldade == 1:
		tempo_de_reação.wait_time = 2
	elif Global.pontuaçãoAtual == 2:
		tempo_de_reação.wait_time = 1.75
	elif Global.pontuaçãoAtual == 3:
		tempo_de_reação.wait_time = 1.5
	elif Global.pontuaçãoAtual >= 4:
		tempo_de_reação.wait_time = 1.5

func aumentarDificuldade():
	Global.nivelDificuldade += 1
	checkDificuldade()

func acerto(tempoReação):
	var tempoLimite = tempo_de_reação.wait_time
	var points:int = clamp(tempoReação / tempoLimite, 0.2, 1.0) * 100.0
	Global.addPoints(points)
