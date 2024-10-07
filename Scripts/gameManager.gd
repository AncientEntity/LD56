extends Node

@onready var money_lable: Label = %money_lable

var max_left = 2
var max_right = 2

#base cost for first grass on each side
var grass_cut_cost = 500

var house_cost = 100
var farm_cost = 200
var mine_cost = 300
var tower_cost = 300

var money = 1000000

var roundState = CEnums.ERoundState.Invasion
var roundTimeLeft
var roundTime = 45
var roundNumber = 0

var bugs = [preload("res://Scenes/bugs/WalkBug.tscn")]
var rng = RandomNumberGenerator.new()

func update_lables():
	money_lable.update_text()

func _ready() -> void:
	roundTimeLeft = roundTime

func _process(delta: float) -> void:
	handleWave(delta)

func handleWave(delta : float):
	roundTimeLeft -= delta
	if roundTimeLeft <= 0:
		roundNumber += 1
		roundTimeLeft = roundTime
		%WaveUI/WaveLabel.text = "Wave "+str(roundNumber)+" INCOMING"
		%WaveUI/WaveLabel.visible = true
		roundState = CEnums.ERoundState.Invasion
		
		var leftCount = 0
		var rightCount = 0
		for i in clamp(int(roundNumber**0.85),1,999):
			var newBug = bugs[rng.randi_range(0,bugs.size()-1)].instantiate()
			if rng.randi_range(0,100) <= 50:
				newBug.set_global_position($"../WORLD/GrassLeft/LeftWall".global_position)
				leftCount += 1
				newBug.position.x -= leftCount * 50
				newBug.direction = 1
			else:
				newBug.set_global_position($"../WORLD/GrassRight/RightWall".global_position)
				rightCount += 1
				newBug.position.x += rightCount * 50
				newBug.direction = -1
			get_node("../WORLD").add_child(newBug)
			newBug.position.y -= 75
	elif roundTimeLeft <= roundTime - 2.0 and roundTimeLeft >= roundTime / 2:
		%WaveUI/WaveLabel.visible = false
	elif roundTimeLeft <= roundTime / 2:
		%WaveUI/WaveLabel.visible = true
		%WaveUI/WaveLabel.text = "Wave Defeated"
		roundState = CEnums.ERoundState.Peaceful
	elif roundTimeLeft <= roundTime / 2 - 2:
		%WaveUI/WaveLabel.visible = false
	
