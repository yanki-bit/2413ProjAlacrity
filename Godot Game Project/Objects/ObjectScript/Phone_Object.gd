extends Node2D

var state = PlayerInfo.state
# Called when the node enters the scene tree for the first time.
func _ready():
	if state["Bedroom"] == false:
		$Sprite2D/Actionable.connect("interacted", Callable(self, "next_dialogue"))
	else:
		next_dialogue()

func next_dialogue():
	$Sprite2D/Actionable.dialogue_start = "Phone2"
