extends CharacterBody2D

@onready var fish: Sprite2D = $Fish

var andar_esquerda: bool

func _ready() -> void:
	if andar_esquerda:
		velocity.x = -30
	else:
		fish.flip_h = true
		velocity.x = 30

func _physics_process(delta: float) -> void:
	move_and_slide()

func _on_timer_timeout() -> void:
	queue_free()

func _on_hitbox_body_entered(body: Node2D) -> void:
	body.coins += 1
	body.released = true
	queue_free()
