extends Control



func _ready():
	for n in $Control.get_children():
		if n.name in LevelState.unlocked:
			n.disabled = false
			n.connect("pressed", self, "change", [n.name, get_node("Control/" + n.name).get_global_position()])
			n.connect("mouse_entered", self, "button_noise", ["2"])
		else:
			n.disabled = true
			n.connect("mouse_entered", self, "button_noise", ["1"])
			
	$Sprite.set_frame(LevelState.unlocked.size() - 1)
	
	if LevelState.unlocked.size() == 16:
		$"Complete Music".play()
	else:
		$"Normal Music".play()

func change(level, pos):
	pos[0] += 30
	pos[1] += 30
	var scene = "res://levels/Level_" + level + ".tscn"
	SceneChange.scene_change(scene, pos)

func button_noise(num):
	get_node("Button Noise" + num).play()
