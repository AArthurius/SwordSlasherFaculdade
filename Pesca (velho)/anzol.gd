extends CharacterBody2D

@onready var label: Label = $"../Control/Label"



const ACC = 200

var is_pressed = false
var released = false
var retracting = false
var coins = 0

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.is_pressed():
			is_pressed = true
		if event.is_released():
			released = true
			is_pressed = false

func _process(delta: float) -> void:
	label.text = str(coins)


func _physics_process(delta: float) -> void:
	
	if released:
		release(delta)
	elif is_pressed and !released:
		velocity.y += ACC * delta
	
	velocity.y = clamp(velocity.y ,-300, 300)
	
	move_and_slide()

func release(delta):
	if position.y > -104:
		velocity.y = -300
	else:
		position.y = -104
		velocity.y = 0
		released = false
