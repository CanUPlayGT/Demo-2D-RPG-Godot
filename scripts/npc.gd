extends CharacterBody2D

signal dialogue_requested(dialogue : Array)

@export_file_path(".json") var dialogue_file_path : String

var can_interact := false
var is_interacting := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not is_interacting:
		if can_interact:
			if Input.is_action_just_pressed("interact"):
				show_dialogue()

func load_dialogue() -> Array:
	var dialogue_file: FileAccess = FileAccess.open(dialogue_file_path, FileAccess.READ)
	var d_file_text : String = dialogue_file.get_as_text()
	var content := JSON.parse_string(d_file_text) as Array
	return content
	
func show_dialogue() -> void:
	is_interacting = true	
	var dialogue : Array = load_dialogue()

	dialogue_requested.emit(dialogue)
	
func _on_interact_body_entered(body: Node2D) -> void:
	if body is Player:
		can_interact = true

func _on_interact_body_exited(body: Node2D) -> void:
	if body is Player:
		can_interact = false
		
func _on_dialogue_player_dialogue_finished() -> void:
	is_interacting = false
