extends Control

@onready var gradeLabel: Label = $gradeLabel
@onready var streakLabel: Label = $streakLabel
@onready var scoreLabel: Label = $scoreLabel
@onready var tempo_de_reação: Timer = $"../Tempo de reação Label/Tempo de reação"
@onready var animation: AnimationPlayer = $Animation

var streak:int = 0
var grade:String = ""
var gradeLabelOriginalPosition: Vector2

func _ready() -> void:
	checkDificuldade()
	gradeLabelOriginalPosition = gradeLabel.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scoreLabel.text = str(Global.pontuaçãoAtual)

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
	pop(scoreLabel)
	pop(streakLabel)
	streak += 1
	updateStreak()
	updateGrade()
	Global.addPoints(points)

func erro():
	streak = 0
	updateStreak()
	updateGrade()
	gradeLabel.position = gradeLabelOriginalPosition

func updateStreak():
	streakLabel.text = str(streak) + " Streak"

func pop(object):
	var tween = create_tween()
	tween.tween_property(object, "scale", Vector2(1.4, 1.4), 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(object, "scale", Vector2(1, 1), 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

func updateGrade():
	if streak < 5 and grade != "":
		grade = ""
		gradeLabel.glide = false
	if streak > 5 and streak < 10 and grade != "D":
		pop(gradeLabel)
		grade = "D"
		gradeLabel.glide = false
	elif streak > 10 and streak < 15 and grade != "C":
		pop(gradeLabel)
		grade = "C"
		gradeLabel.glide = false
	elif streak > 15 and streak < 20 and grade != "B":
		pop(gradeLabel)
		grade = "B"
		gradeLabel.glide = false
	elif streak > 20 and streak < 30 and grade != "A":
		pop(gradeLabel)
		grade = "A"
		gradeLabel.glide = true
	elif streak > 30 and grade != "S":
		pop(gradeLabel)
		grade = "S"
		gradeLabel.glide = true
	
	gradeLabel.text = grade
