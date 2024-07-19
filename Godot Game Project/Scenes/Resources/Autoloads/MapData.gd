extends Node

var MAPS = {
	"Classroom" : {
		"scene_path" = "res://Scenes/School/classroom.tscn",
		"spawn_location" = Vector2(128,-137),
		"spawn_direction" = Vector2(-1,0)
	},

	"Hallway" : {
		"scene_path" = "res://Scenes/School/hallway.tscn",
		"spawn_location_west" = Vector2(0,0),
		"spawn_direction_west" = Vector2(1,0),
		"spawn_location_north" = Vector2(0,0),
		"spawn_direction_north" = Vector2(0,1),
		"spawn_location_south" = Vector2(0,0),
		"spawn_direction_south" = Vector2(0,-1)
	},
	
	"Library" : {
		"scene_path" = "res://Scenes/School/library.tscn",
		"spawn-location" = Vector2(0,0),
		"spawn_direction" = Vector2(0,-1)
	}
}
