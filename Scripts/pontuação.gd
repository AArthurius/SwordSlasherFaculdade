extends Control

@onready var label: Label = $Label
@onready var tempo_de_reação: Timer = $"../Tempo de reação Label/Tempo de reação"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = str(Global.pontuaçãoAtual)
	
	

func aumentarDificuldade():
	Global.nivelDificuldade += 1
	
	if Global.nivelDificuldade == 2:
		tempo_de_reação.wait_time = 3
	elif Global.pontuaçãoAtual == 4:
		tempo_de_reação.wait_time = 1.5
	elif Global.pontuaçãoAtual == 5:
		tempo_de_reação.wait_time = 1
	elif Global.pontuaçãoAtual == 6:
		tempo_de_reação.wait_time = 0.5

func acerto(tempoReação):
	var tempoLimite = tempo_de_reação.wait_time
	var points:int = clamp(tempoReação / tempoLimite, 0.2, 1.0) * 100.0
	Global.addPoints(points)
