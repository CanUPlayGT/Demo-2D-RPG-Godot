class_name Player

extends CharacterBody2D

@export_category("Stats")
@export var speed : int = 480
var move_direction : Vector2 = Vector2.ZERO

# Initial sprite direction
var sprite_direction : String = "down"
@onready  var animated_sprite := $AnimatedSprite2D


func _physics_process(_delta: float) -> void:
	movement_loop()
 
func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	pass

func movement_loop() -> void:
	move_direction = Input.get_vector("left", "right", "up", "down")
	
	# This is just ternary operator
	# to give flip_h value based on 
	# input direction (left or right) 
	animated_sprite.flip_h = (
		animated_sprite.flip_h 
		if move_direction.x == 0 
		else true if move_direction.x < 0 
		else false
	) 
	# flip horizontally if input direction is left
	
	match move_direction:
		Vector2.RIGHT:
			sprite_direction = "right"
		Vector2.LEFT:
			sprite_direction = "right"
		Vector2.UP:
			sprite_direction = "up"		
		Vector2.DOWN:
			sprite_direction = "down"
	
	play_move_animation(sprite_direction)
	
	velocity = move_direction * speed
	move_and_slide()
	
func play_move_animation(direction : String) -> void:
	if move_direction != Vector2.ZERO:
		animated_sprite.play("move_" + direction)
	else:
		animated_sprite.play("idle_" + direction)
