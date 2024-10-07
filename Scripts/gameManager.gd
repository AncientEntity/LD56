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
var roundTime = 10
var roundNumber = 0

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
	elif roundTimeLeft <= roundTime - 2.0:
		%WaveUI/WaveLabel.visible = false
