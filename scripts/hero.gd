class_name Player

extends CharacterBody2D

@export_category("Stats")
@export var speed : int = 480

var move_direction : Vector2 = Vector2.ZERO
var can_move := true
# Initial sprite direction
var sprite_direction : String = "down"

@onready  var animated_sprite := $AnimatedSprite2D

enum state{
	idle,
	walking,
	running,
}

var current_state : state

func _physics_process(_delta: float) -> void:
	if can_move:
		movement_loop()
 	
func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	pass

func movement_loop() -> void:
	move_direction = Input.get_vector("left", "right", "up", "down")

	if move_direction != Vector2.ZERO and Input.is_action_pressed("run"):
		current_state = state.running
	elif move_direction != Vector2.ZERO:
		current_state = state.walking
	else:
		current_state = state.idle
		
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
	
	var speed_modifier := 2 if current_state == state.running else 1
	velocity = move_direction * speed * speed_modifier
	move_and_slide()
	
func play_move_animation(direction : String) -> void:
	match current_state:
		state.running:
			animated_sprite.play("run_" + direction)
		state.walking:
			animated_sprite.play("move_" + direction)
		state.idle:
			animated_sprite.play("idle_" + direction)


func _on_dialogue_player_dialogue_opened() -> void:
	can_move = false


func _on_dialogue_player_dialogue_finished() -> void:
	can_move = true
