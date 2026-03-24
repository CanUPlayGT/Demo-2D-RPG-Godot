extends CanvasLayer

signal dialogue_finished

@onready var name_label : Label = $MarginContainer/Panel/VBoxContainer/Label
@onready var content : RichTextLabel = $MarginContainer/Panel/VBoxContainer/MarginContainer/RichTextLabel

var current_dialogue_id : int = 0
var dialogue : Array 
var is_playing := false

func _process(_delta: float) -> void:
		if is_playing:
			visible = true
			if Input.is_action_just_pressed("interact"):
				next_dialogue()
				
func next_dialogue() -> void :
	if current_dialogue_id > dialogue.size() - 1:
		stop_dialogue()
		return

	name_label.text = dialogue[current_dialogue_id]["name"]
	content.text = dialogue[current_dialogue_id]["text"]
	
	current_dialogue_id += 1
	
func stop_dialogue() -> void:
	is_playing = false
	visible = false
	dialogue = []
	current_dialogue_id = 0
	dialogue_finished.emit()
	
func _on_npc_dialogue_requested(array: Array) -> void:
	dialogue = array
	is_playing = true
	
	
