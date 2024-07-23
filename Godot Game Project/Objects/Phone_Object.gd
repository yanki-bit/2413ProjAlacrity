extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D/Actionable.connect("interacted", Callable(self, "next_dialogue"))

func next_dialogue():
	$Sprite2D/Actionable.dialogue_start = "Phone2"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
