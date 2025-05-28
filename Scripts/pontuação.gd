extends Control

@onready var label: Label = $Label
@onready var tempo_de_reação: Timer = $"../Tempo de reação Label/Tempo de reação"


func _process(delta: float) -> void :
	label.text = str(Global.pontuaçãoAtual)

	if Global.pontuaçãoAtual > 10000:
		tempo_de_reação.wait_time = 0.5
	elif Global.pontuaçãoAtual > 6000:
		tempo_de_reação.wait_time = 1
	elif Global.pontuaçãoAtual > 3000:
		tempo_de_reação.wait_time = 1.5
	elif Global.pontuaçãoAtual > 1000:
		tempo_de_reação.wait_time = 2

func acerto(tempoReação):
	var tempoLimite = tempo_de_reação.wait_time
	var points: int = clamp(tempoReação / tempoLimite, 0.2, 1.0) * 100.0
	Global.addPoints(points)
