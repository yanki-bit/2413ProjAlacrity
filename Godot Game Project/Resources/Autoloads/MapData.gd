extends Node

var MAPS = {
	"Classroom" : {
		"scene_path" = "res://Scenes/School/classroom.tscn",
		"spawn_location" = Vector2(128,-137),
		"spawn_direction" = Vector2(-1,0)
	},

	"Hallway" : {
		"scene_path" = "res://Scenes/School/hallway.tscn",
		"spawn_location_west" = Vector2(79,-332),
		"spawn_direction_west" = Vector2(1,0),
		"spawn_location_north" = Vector2(404,-397),
		"spawn_direction_north" = Vector2(0,1),
		"spawn_location_south" = Vector2(566,-253),
		"spawn_direction_south" = Vector2(0,-1)
	},
	
	"Library" : {
		"scene_path" = "res://Scenes/School/library.tscn",
		"spawn_location" = Vector2(1,-121),
		"spawn_direction" = Vector2(0,-1)
	},
	
	"Bedroom" : {
		"scene_path" = "res://Scenes/School/bedroom.tscn",
		"spawn_location" = Vector2(0,-4),
		"spawn_direction" = Vector2(0,-1)
	},
	
	"Work" : {
		"scene_path" = "res://Scenes/Workplace.tscn",
		"spawn_location" = Vector2(113,286),
		"spawn_direction" = Vector2(0,-1)
	}
}
