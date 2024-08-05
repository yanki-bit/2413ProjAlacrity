extends Area2D
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
signal interacted
signal contact
#collision layer 5 must be active
func action() -> void:
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
	emit_signal("interacted")
	

func _on_body_entered(body):
	if "Player" in body.name:
		emit_signal("contact")
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
