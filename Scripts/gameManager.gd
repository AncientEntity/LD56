extends Node

@onready var money_lable: Label = %money_lable
@onready var camera: Camera2D = $"../Camera2D"
@onready var round_lable: Label = $"../Camera2D/Round_lable"
@onready var moneyadded: Label = $"../Camera2D/WaveUI/moneyadded"

var life = 3

var max_left = 2
var max_right = 2

#base cost for first grass on each side
var grass_cut_cost = 400
var grass_cut_cost_scale = 200

var house_cost = 100
var farm_cost = 50
var mine_cost = 300
var tower_cost = 500

var money = 450

var roundState = CEnums.ERoundState.Invasion
var roundTimeLeft
var roundTime = 30
var roundNumber = 0


@onready var lost_delay = 3
var lost = false

var bugs = [preload("res://Scenes/bugs/WalkBug.tscn")]
var bug_offset = 1000
var rng = RandomNumberGenerator.new()

func update_lables():
	money_lable.update_text()
	round_lable.update_text()
	

func _ready() -> void:
	roundTimeLeft = roundTime / 2 - 3

func _process(delta: float) -> void:
	if(lost):
		lost_delay -= delta
		if(lost_delay <= 0):
			camera.show_end_screen()
	handleWave(delta)

func _lost():
	camera.position.x = 0
	lost = true

func handleWave(delta : float):
	roundTimeLeft -= delta
	if roundTimeLeft <= 0:
		roundNumber += 1
		var added_money = 200 + roundNumber*50
		money += added_money
		roundTimeLeft = roundTime
		%WaveUI/WaveLabel.text = "Wave "+str(roundNumber)+" INCOMING"
		moneyadded.text = "+$" + str(added_money)
		%WaveUI/WaveLabel.visible = true
		moneyadded.visible = true
		roundState = CEnums.ERoundState.Invasion
		
		var leftCount = 0
		var rightCount = 0
		#for i in clamp(int(roundNumber**0.85),1,999):
		for i in clamp(roundNumber,1,999):
			var newBug = bugs[rng.randi_range(0,bugs.size()-1)].instantiate()
			if rng.randi_range(0,100) <= 50:
				newBug.set_global_position($"../WORLD/GrassLeft/LeftWall".global_position)
				newBug.position.x -= randi_range(bug_offset, bug_offset*2)
				leftCount += 1
				newBug.position.x -= leftCount * 50
				newBug.direction = 1
			else:
				newBug.set_global_position($"../WORLD/GrassRight/RightWall".global_position)
				newBug.position.x += randi_range(bug_offset, bug_offset*2)
				rightCount += 1
				newBug.position.x += rightCount * 50
				newBug.direction = -1
			var round_mod = roundNumber * 0.05
			var size_rng = randf_range((0.3 + round_mod), 0.6 + round_mod)
			newBug.scale *= size_rng-0.05
			newBug.speed = newBug.speed + newBug.speed * (0.5 + round_mod)/(size_rng*2)
			newBug.health = float(newBug.maxHealth) * size_rng + float(roundNumber) * 30.0
			newBug.damage = (float(newBug.damage) + 2*roundNumber) * size_rng
			get_node("../WORLD").add_child(newBug)
			newBug.position.y -= 200
	elif roundTimeLeft <= roundTime - 2.0 and roundTimeLeft >= roundTime:
		%WaveUI/WaveLabel.visible = false
		moneyadded.visible = false
	elif roundTimeLeft <= roundTime / 2 and roundTimeLeft > roundTime - 2:
		%WaveUI/WaveLabel.visible = true
		moneyadded.visible = true
		#%WaveUI/WaveLabel.text = "Wave Defeated"
		roundState = CEnums.ERoundState.Peaceful
	elif roundTimeLeft <= roundTime / 2 - 2:
		%WaveUI/WaveLabel.visible = false
		moneyadded.visible = false
	
